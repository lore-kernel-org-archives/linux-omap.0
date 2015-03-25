From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/1] usb: musb: dsps: fix build on i386 when COMPILE_TEST is set
Date: Wed, 25 Mar 2015 14:18:37 -0700
Message-ID: <1427318317-13927-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ar-005-i203.relay.mailchannels.net ([162.253.144.85]:48374 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752148AbbCYVXN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2015 17:23:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, George Cherian <george.cherian@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Commit 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with musb_ds=
ps")
fixed a USB error on dm816x, but introduced a new build error on i386
when COMPILE_TEST is set:

drivers/usb/musb/musb_dsps.c: In function =E2=80=98dsps_read_fifo32=E2=80=
=99:
drivers/usb/musb/musb_dsps.c:624:3: error: implicit declaration of func=
tion
=E2=80=98readsl=E2=80=99 [-Werror=3Dimplicit-function-declaration]
readsl(fifo, dst, len >> 2);

Let's fix this by using ioread32_rep() instead of readsl() as that's
more portable.

=46ixes: 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with musb_=
dsps")
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Cc: Bin Liu <binmlist@gmail.com>
Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: George Cherian <george.cherian@ti.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_dsps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.=
c
index 2c0750e..8e089c1 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -661,7 +661,7 @@ static void dsps_read_fifo32(struct musb_hw_ep *hw_=
ep, u16 len, u8 *dst)
 	void __iomem *fifo =3D hw_ep->fifo;
=20
 	if (len >=3D 4) {
-		readsl(fifo, dst, len >> 2);
+		ioread32_rep(fifo, dst, len >> 2);
 		dst +=3D len & ~0x03;
 		len &=3D 0x03;
 	}
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
