From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] Fix isp1301_omap compile (Re: testers wanted: isp1301_omap
	conversion to new-style i2c driver)
Date: Mon, 11 Aug 2008 18:24:11 +0300
Message-ID: <20080811152410.GN25784@atomide.com>
References: <20080617204300.77c8e516@hyperion.delvare> <20080807183416.115c67ba@hyperion.delvare> <200808071651.43297.david-b@pacbell.net> <20080808072954.GH24923@atomide.com> <20080808111751.494702cc@hyperion.delvare> <20080808094551.GP24923@atomide.com> <20080808094853.GW30719@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58060 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbYHKPZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 11:25:57 -0400
Content-Disposition: inline
In-Reply-To: <20080808094853.GW30719@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Jean Delvare <khali@linux-fr.org>, David Brownell <david-b@pacbell.net>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Deepak Saxena <dsaxena@plexity.net>, carlos.aguiar@indt.org.br


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Felipe Balbi <felipe.balbi@nokia.com> [080808 12:49]:
> On Fri, Aug 08, 2008 at 12:45:52PM +0300, Tony Lindgren wrote:
> > Yeah, I will add it to linux-omap for testing for sure. This should be
> > easy to test though, it either works or does not.. But we need to find
> > somebody to boot it and connect USB cable to it :)
> 
> Hi Carlos,
> 
> could you test it for us on H2 ??
> 
> Do you guys still have H2 boards there ?

Also H4 needs to be tested.

I've synced linux-omap tree with mainline tree at v2.6.27-rc2, and
applied Felipe's and Jean's patches. Following patch should be merged
to them to fix compile.

Regards,

Tony

--2fHTh5uZTiUOsy+g
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="i2c-isp1301-omap-fix.patch"

>From d12a00e66e97f2e808217eb3e9c9e88d4a281530 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 11 Aug 2008 17:45:32 +0300
Subject: [PATCH] I2C: Fix isp1301_omap.c compile

Fix isp1301_omap.c compile

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index c250668..71a0a2e 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -1210,7 +1210,7 @@ static void isp1301_release(struct device *dev)
 {
 	struct isp1301	*isp;
 
-	isp = device_get_drvdata(dev);
+	isp = dev_get_drvdata(dev);
 
 	/* ugly -- i2c hijacks our memory hook to wait_for_completion() */
 	if (isp->i2c_release)
@@ -1564,7 +1564,7 @@ static int __init isp1301_probe(struct i2c_client *i2c)
 	if (machine_is_omap_h2()) {
 		/* full speed signaling by default */
 		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1,
-			MC1_SPEED_REG);
+			MC1_SPEED);
 		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_2,
 			MC2_SPD_SUSP_CTRL);
 

--2fHTh5uZTiUOsy+g--
