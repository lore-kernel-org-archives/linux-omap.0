From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/5] omap device tree changes for v3.6 merge window
Date: Tue, 7 Aug 2012 00:13:51 -0700
Message-ID: <20120807071351.GK11011@atomide.com>
References: <pull-1341925556-888624>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A8BE1@DBDE01.ent.ti.com>
 <20120713064147.GG1122@atomide.com>
 <20120713075658.GQ1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43544 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab2HGHN4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 03:13:56 -0400
Content-Disposition: inline
In-Reply-To: <20120713075658.GQ1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Tony Lindgren <tony@atomide.com> [120713 01:01]:
> * Tony Lindgren <tony@atomide.com> [120712 23:46]:
> > * Mohammed, Afzal <afzal@ti.com> [120712 23:19]:
> > > > Afzal Mohammed (1):
> > > >       arm/dts: am33xx wdt node
> > > 
> > > The above patch seems to be an empty one, actual changes in it as in
> > > original patch [1] is missing, same changes are shown below for your
> > > reference [2].
> > > 
> > > Can you please do the needful so that the intended change of this
> > > patch makes to mainline this merge window.
> > 
> > Argh. Thanks for letting me know. I must have something wrong with
> > my scripts when applying patches. We'll have to apply this as a fix.
> 
> Arnd and Olof, let me know if you want me to resubmit a new branch instead
> of the already pulled devel-dt branch. That branch should not have other
> dependencies as it's based on -rc5. Of course is it's buried into other
> DT patches it's too late.

Now with -rc1 out, I'll queue the following fix.

Regards,

Tony

From: Afzal Mohammed <afzal@ti.com>
Date: Wed, 4 Jul 2012 18:00:37 +0530
Subject: [PATCH] arm/dts: Fix am33xx wdt node

Add am33xx wdt node.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
[tony@atomide.com: I messed up and produced an empty commit db27ac80 with stg apply]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 59509c4..bd0cff3 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -154,5 +154,10 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
 		};
+
+		wdt2: wdt@44e35000 {
+			compatible = "ti,omap3-wdt";
+			ti,hwmods = "wd_timer2";
+		};
 	};
 };
