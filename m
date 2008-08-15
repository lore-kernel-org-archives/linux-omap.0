From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/4] Refreshed PM workaround patches 2.
Date: Fri, 15 Aug 2008 10:49:41 +0300
Message-ID: <20080815074937.GI16231@frodo>
References: <87iqu2rac0.fsf@trdhcp146196.ntc.nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60615 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbYHOHts (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 03:49:48 -0400
Content-Disposition: inline
In-Reply-To: <87iqu2rac0.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: H?gander Jouni <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

On Fri, Aug 15, 2008 at 10:44:47AM +0300, H?gander Jouni wrote:
> Refreshed PM workaround set without coding style errors and 24xx buil=
d
> fixed. Here are instructions how to test them:
>=20
> To get Omap into retention, this patch set still depends on:
> 1. ARCH: OMAP: MUSB: Do not block sleep (Felipe Balbi)

I thought it had been applied. Probably lost while tony was on
vacations. Anyways, here it is:

=46rom: Felipe Balbi <felipe.balbi@nokia.com>

arch: omap: usb: do not block sleep

musb_set_clock should not block sleep on omap3-based
boards, it prevents system from sleeping.

Thanks to Jouni H=F6gander for pointing this out

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-m=
usb.c
index 71ddf55..3f90a93 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -58,7 +58,6 @@ static int musb_set_clock(struct clk *clk, int state)
                if (clk_on > 0)
                        return -ENODEV;
=20
-               omap2_block_sleep();
                clk_enable(clk);
                clk_on =3D 1;
        } else {
@@ -67,7 +66,6 @@ static int musb_set_clock(struct clk *clk, int state)
=20
                clk_disable(clk);
                clk_on =3D 0;
-               omap2_allow_sleep();
        }
=20
        return 0;

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
