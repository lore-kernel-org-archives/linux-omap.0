From: "Premi, Sanjeev" <premi@ti.com>
Subject: Query on new mux usage
Date: Tue, 29 Dec 2009 19:12:50 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E1C30C1E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52195 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbZL2Nmz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 08:42:55 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBTDgpk4018798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 29 Dec 2009 07:42:54 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBTDgp0r005981
	for <linux-omap@vger.kernel.org>; Tue, 29 Dec 2009 19:12:51 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
 
I am trying to define the mux settings for keypad on the omap3evm.
I had a few queries on the same.
 
1) Is it enough to me this change:
 
 static struct omap_board_mux board_mux[] __initdata = {
+
+       /* SYS_NIRQ */
+       OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
+						OMAP_PIN_OFF_INPUT_PULLUP),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },

2) Or should I follow with this (in the evm init code):
 
+	omap_mux_init_signal("af26", OMAP_PIN_INPUT_PULLUP |
+						OMAP_PIN_OFF_INPUT_PULLUP);

3) OR is this a better(or worse)

 static struct omap_board_mux board_mux[] __initdata = {
+
+       /* SYS_NIRQ */
+       OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },

..and later
 
+	omap_mux_init_signal("af26", OMAP_PIN_INPUT_PULLUP |
+						OMAP_PIN_OFF_INPUT_PULLUP);

Best regards,
Sanjeev
