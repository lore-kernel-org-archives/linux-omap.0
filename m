From: Marc Butler <marc@plastictigers.com>
Subject: [RFC PATCH] slimbus message encoding/decoding
Date: Thu, 8 Mar 2012 19:21:06 -0500
Message-ID: <20120309002106.GA605@plastictigers.com>
Reply-To: marc@plastictigers.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li158-162.members.linode.com ([173.230.148.162]:45579 "EHLO
	plastictigers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758959Ab2CIAVG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 19:21:06 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sdharia@codeaurora.org, kheitke@codeaurora.org
Cc: gclemson@audience.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

All,

This patch provides generic functions for encoding/decoding SLIMbus
messages (Section 8 of the specification).

This message API is built around the conjecture that the vast majority
of transactions will be using short arbitration, and a logical address
destination type. So there are separate functions for handling
short/long arbitration fields, logical/enumerated/broadcast header
fields.

This work has been done in separate files slimbus-msg.[ch] to avoid
collision with work in the main (slimbus.*) patch. The API is internal
to slimbus, and I do not anticipate slimbus device drivers needing
these functions.

No CRC generator is included for the PI and MI fields. The OMAP4430
chip this is being tested on generates and populates these fields in
h/w. However, I have include a general (and untested) callback
mechanism.

-m

Signed-off-by: Marc Butler <marc@plastictigers.com>
---
drivers/slimbus/slimbus-msg.c |  242 +++++++++++++++++++++++++++++++++++++++++
 drivers/slimbus/slimbus-msg.h |   70 ++++++++++++
 2 files changed, 312 insertions(+), 0 deletions(-)

diff --git a/drivers/slimbus/slimbus-msg.c b/drivers/slimbus/slimbus-msg.c
new file mode 100644
index 0000000..c88974e
--- /dev/null
+++ b/drivers/slimbus/slimbus-msg.c
@@ -0,0 +1,242 @@
+/* Copyright (c) 2012, Audience Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include "slimbus-msg.h"
+
+/**
+ * slim_msg_scout() - quickly extract important information.
+ * @msg:	Valid binary message.
+ * @mt:		Message type.
+ * @mc:		Message code.
+ * @atype:	Address type.
+ * @paddr:	Pointer to destination address in message. Will be
+ *		Null if atype == broadcast.
+ * @plen:	Payload length in bytes.
+ * @pdat:	Pointer to first byte of payload. Null if plen == 0.
+ *
+ * This function is intended to aid parsing and handling incoming
+ * messages, by quickly extracting commonly referenced fields.
+ */
+int slim_msg_scout(struct slim_msg *msg, u8 *mt, u8 *mc, int *atype, u8 **paddr,
+		   u8 *plen, u8 **pdat)
+{
+	u8 i = 0;
+	u8 tmp;
+	u8 rlen;
+	u8 alen;
+
+	if (msg->len < SLIM_MSG_MINLEN) {
+		pr_err("slimbus: message with invalid length = %u\n", msg->len);
+		return -1;
+	}
+
+	/* Skip arbitration header. */
+	tmp = msg->b[0] >> 4;
+	switch (tmp) {
+	case 0xf:
+		i += 2; /* Short = logical address. */
+		break;
+	case 0x5:
+		i += 7; /* Long = enumerated address. */
+		break;
+	default:
+		pr_err("slimbus: unknown arbitration type = 0x%x\n", tmp);
+		return -1;
+	}
+
+	/* Cache the length of the arbitration portion. */
+	alen = i;
+	rlen = msg->b[i] & 0x1f;
+	*mt = msg->b[i++] >> 5;
+	*mc = msg->b[i++];
+
+	/* Extract the destination address. */
+	tmp = msg->b[i++] >> 4;
+	*atype = tmp;
+	switch (tmp) {
+	case SLIM_MSG_DEST_LOGICALADDR:
+		*paddr = &msg->b[i++];
+		break;
+	case SLIM_MSG_DEST_ENUMADDR:
+		*paddr = &msg->b[i];
+		i += 6;
+		break;
+	case SLIM_MSG_DEST_BROADCAST:
+		*paddr = NULL;
+		break;
+	default:
+		pr_warn("Slimbus invalid dt=0x%x\n", tmp);
+		return -1;
+	}
+
+	/*
+	 * Payload length = remaining length - header - 1 (MR+MI byte).
+	 *
+	 * We do not need to account for the MR+MI byte as i includes
+	 * the byte that contains remaining length (rlen), which is
+	 * not included by the specification. However, this means we
+	 * can simply ignore the -1 adjustment for the MR+MI byte.
+	 */
+	*plen = rlen - (i - alen);
+	*pdat = (*plen > 0) ? &msg->b[i] : NULL;
+	return 0;
+}
+
+/**
+ * slim_ins_arb_short() - insert a short arbitration field.
+ * @msg:	Empty message.
+ * @pri:	Arbitration priority.
+ * @la:		Logical address.
+ *
+ * The Arbitation Extension field (Spec: 8.2.1.2) is assumed to be
+ * Normal, as it is unclear to me if Reserved is valid.
+ */
+void slim_ins_arb_short(struct slim_msg *msg, u8 pri, u8 la)
+{
+	BUG_ON(msg->len > 0);
+	msg->b[msg->len++] = (SLIM_AT_SHORT << 4) | (pri & 0x7);
+	msg->b[msg->len++] = la;
+}
+
+/**
+ * slim_ins_arb_long() - insert a long arbitration field.
+ * @msg:	Empty message.
+ * @pri:	Arbitration priority.
+ * @la:		Enumerated address.
+ *
+ * The Arbitation Extension field (Spec: 8.2.1.2) is assumed to be
+ * Normal, as it is unclear to me if Reserved is valid.
+ */
+void slim_ins_arb_long(struct slim_msg *msg, u8 pri, u8 *ea)
+{
+	BUG_ON(msg->len > 0);
+	msg->b[msg->len++] = (SLIM_AT_LONG << 4) | (pri & 0x7);
+	msg->b[msg->len++] = *ea++;
+	msg->b[msg->len++] = *ea++;
+	msg->b[msg->len++] = *ea++;
+	msg->b[msg->len++] = *ea++;
+	msg->b[msg->len++] = *ea++;
+	msg->b[msg->len++] = *ea++;
+}
+
+/**
+ * slim_ins_hdr_la() -	insert a logical address header field.
+ * @msg:	Message already containing arbitration field.
+ * @mt:		Message type.
+ * @mc:		Message code.
+ * @plen:	Payload length.
+ * @la:		Logical address.
+ * @crcgen:	Optional 4-bit CRC generator.
+ *
+ * The remaining length field will be calculated based on the payload
+ * length @plen.
+ */
+void slim_ins_hdr_la(struct slim_msg *msg, u8 mt, u8 mc, u8 plen, u8 la,
+		     slim_crc_gen crcgen)
+{
+	/* Account for the 3 bytes following this field, the payload,
+	 * and +1 for the MR+MI field.
+	 */
+	msg->b[msg->len++] = (mt << 5) | (plen + 3 + 1);
+	msg->b[msg->len++] = mc & 0x7f;
+	if (crcgen)
+		msg->b[msg->len] |= crcgen(msg);
+	msg->b[msg->len++] |= SLIM_MSG_DEST_LOGICALADDR << 4;
+	msg->b[msg->len++] = la;
+}
+
+/**
+ * slim_ins_hdr_ea() -	insert an enumerated address header field.
+ * @msg:	Message already containing arbitration field.
+ * @mt:		Message type.
+ * @mc:		Message code.
+ * @plen:	Payload length.
+ * @ea:		Pointer to first byte of the enumerated address.
+ * @crcgen:	Optional 4-bit CRC generator.
+ *
+ * The remaining length field will be calculated based on the payload
+ * length @plen.
+ */
+void slim_ins_hdr_ea(struct slim_msg *msg, u8 mc, u8 mt, u8 plen, u8 *ea,
+		     slim_crc_gen crcgen)
+{
+	/* Account for the 7 bytes following this field, the
+	 * payload, and +1 for the MR+MI field.
+	 */
+	msg->b[msg->len++] = (mt << 5) | (plen + 7 + 1);
+	msg->b[msg->len++] = mc & 0x7f;
+	if (crcgen)
+		msg->b[msg->len] = crcgen(msg);
+	msg->b[msg->len++] |= SLIM_MSG_DEST_ENUMADDR << 4;
+	msg->b[msg->len++] = *ea++;
+	msg->b[msg->len++] = *ea++;
+	msg->b[msg->len++] = *ea++;
+	msg->b[msg->len++] = *ea++;
+	msg->b[msg->len++] = *ea++;
+	msg->b[msg->len++] = *ea++;
+}
+
+/**
+ * slim_ins_hdr_bcast() -	insert a broadcast header field.
+ * @msg:	Message already containing arbitration field.
+ * @mt:		Message type.
+ * @mc:		Message code.
+ * @plen:	Payload length.
+ * @ea:		Pointer to first byte of the enumerated address.
+ * @crcgen:	Optional 4-bit CRC generator.
+ *
+ * The remaining length field will be calculated based on the payload
+ * length @plen.
+ */
+void slim_ins_hdr_bcast(struct slim_msg *msg, u8 mc, u8 mt, u8 plen,
+			slim_crc_gen crcgen)
+{
+	/* Account for the 2 bytes following this field, the
+	 * payload, and +1 for the MR+MI field.
+	 */
+	msg->b[msg->len++] = (mt << 5) | (plen + 2 + 1);
+	msg->b[msg->len++] = mc & 0x7f;
+	if (crcgen)
+		msg->b[msg->len] = crcgen(msg);
+	msg->b[msg->len++] |= SLIM_MSG_DEST_BROADCAST << 4;
+}
+
+/**
+ * slim_ins_payload() -	insert a payload.
+ * @msg:	Message containing arbitration and header fields.
+ * @plen:	Payload length in bytes. This *must* match the value
+ *		given to slim_ins_hdr_*().
+ * @pdat:	Pointer to the first byte of the payload.
+ */
+void slim_ins_payload(struct slim_msg *msg, u8 plen, u8 *pdat)
+{
+	while (plen--)
+		msg->b[msg->len++] = *pdat++;
+}
+
+/**
+ * @slim_ins_mi() -	insert message response and
+ *			message integrity fields.
+ * @msg:	Message containing arbitration, header, and
+ *		payload.
+ * @crcgen:	Optional 4-bit CRC generator.
+ */
+void slim_ins_mi(struct slim_msg *msg, slim_crc_gen crcgen)
+{
+	if (!crcgen)
+		msg->b[msg->len] = 0;
+	else
+		msg->b[msg->len] = crcgen(msg);
+	msg->len++;
+}
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/slimbus/slimbus-msg.h b/drivers/slimbus/slimbus-msg.h
new file mode 100644
index 0000000..311ccb6
--- /dev/null
+++ b/drivers/slimbus/slimbus-msg.h
@@ -0,0 +1,70 @@
+/* Copyright (c) 2012, Audience Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef _SLIMBUS_MSG_H
+#define _SLIMBUS_MSG_H
+
+#include <linux/slimbus/slimbus.h>
+
+/* Spec: 8.2 */
+#define SLIM_MSG_MAXLEN	39
+/* Inferred from Spec: 8.2, tbl 24. */
+#define SLIM_MSG_MINLEN	6
+/**
+ * slim_msg -	Slimbus message in binary form.
+ * @len:	Length of the message in bytes.
+ * @b:		Message in binary form.
+ */
+struct slim_msg {
+	u8 len;
+	u8 b[SLIM_MSG_MAXLEN];
+};
+
+#define SLIM_MSG_INIT_EMPTY { .len = 0 }
+
+/* Message arbitration types. Spec: 8.2.1.1. */
+#define SLIM_AT_NONE	0x0
+#define SLIM_AT_LONG	0x5
+#define SLIM_AT_SHORT	0xf
+
+/* Arbitration priority codes. Spec: 8.2.1.3. */
+#define SLIM_AP_LOW	0x01
+#define SLIM_AP_DEFAULT	0x02
+#define SLIM_AP_HIGH	0x03
+#define SLIM_AP_MAX	0x07
+
+/* Callback for 4-bit CRC generator. Spec: 8.2.4.1
+ *
+ * A callback is used so that h/w that the same functions can be used
+ * for drivers that control h/w that will automatically generate and
+ * fill in the integrity fields, such as the TI OMAP4430.
+ */
+typedef u8 (*slim_crc_gen)(struct slim_msg *msg);
+
+int slim_msg_scout(struct slim_msg *msg, u8 *mt, u8 *mc, int *atype, u8 **paddr,
+		   u8 *plen, u8 **pdat);
+
+void slim_ins_arb_short(struct slim_msg *msg, u8 pri, u8 la);
+
+void slim_ins_arb_long(struct slim_msg *msg, u8 pri, u8 *ea);
+
+void slim_ins_hdr_la(struct slim_msg *msg, u8 mt, u8 mc, u8 plen, u8 la,
+		     slim_crc_gen crcgen);
+void slim_ins_hdr_ea(struct slim_msg *msg, u8 mt, u8 mc, u8 plen, u8 *ea,
+		     slim_crc_gen crcgen);
+void slim_ins_hdr_bcast(struct slim_msg *msg, u8 mc, u8 mt, u8 plen,
+			slim_crc_gen crcgen);
+
+void slim_ins_payload(struct slim_msg *msg, u8 plen, u8 *pdat);
+
+void slim_ins_mi(struct slim_msg *msg, slim_crc_gen crcgen);
+
+#endif
