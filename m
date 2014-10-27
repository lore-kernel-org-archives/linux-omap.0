From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.18-rc1
Date: Mon, 27 Oct 2014 12:59:12 -0700
Message-ID: <20141027195912.GQ2560@atomide.com>
References: <alpine.DEB.2.02.1410201804050.4472@utopia.booyaka.com>
 <alpine.DEB.2.02.1410201810160.4472@utopia.booyaka.com>
 <20141027155344.GK2542@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42114 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751862AbaJ0UAb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2014 16:00:31 -0400
Content-Disposition: inline
In-Reply-To: <20141027155344.GK2542@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

* Tony Lindgren <tony@atomide.com> [141027 08:56]:
> * Paul Walmsley <paul@pwsan.com> [141023 08:21]:
> > On Mon, 20 Oct 2014, Paul Walmsley wrote:
> > 
> > > Boot-time memory difference
> > > (delta in bytes from test_v3.17-rc7 (fe82dcec644244676d55a1384c958d5f67979adb))
> > >   avail  rsrvd   high  freed  board          kconfig
> > >  -117908k -13164k      .  -148k  2420n800    omap2plus_defconfig_n800_only_a
> > >  -1012k  1012k      .      .  2430sdp        omap2plus_defconfig
> > >  -1268k  1268k      .    16k  3530es31beagle omap2plus_defconfig
> > >  -1268k  1268k      .    16k  3530es3beagle  omap2plus_defconfig
> > >  -1780k  1780k      .    16k  3730beaglexm   omap2plus_defconfig
> > >  -1780k  1780k      .    16k  3730es12beaglexmomap2plus_defconfig
> > >  -1268k  1268k      .    16k  37xxevm        omap2plus_defconfig
> > >  -2780k  2780k -16384k    16k  4460pandaes    omap2plus_defconfig
> > >  -2776k  2776k -16384k    16k  4460varsomom   omap2plus_defconfig
> > >  -4848k  4848k -16384k    16k  5430es2sbct54  omap2plus_defconfig
> > >  -4800k  4800k -16384k    16k  5430es2uevm    omap2plus_defconfig
> > >   -996k   996k      .     8k  am335xbone     omap2plus_defconfig_am33xx_only
> > >  -1268k  1268k      .    16k  am335xbonelt   omap2plus_defconfig
> > > 
> > > 
> > > The size of an omap2plus_defconfig kernel has increased by 760K - a 
> > > remarkable increase that fortunately does not appear to be matched by 
> > > runtime memory consumption.
> > 
> > Well let's take that back.  I seem to have glazed over the 1 to 4MB (!) 
> > runtime memory usage increases in boot memory consumption.  That is also 
> > an extraordinary increase.
> 
> Probably mostly caused by 673ce00c5d6c (ARM: omap2plus_defconfig: Add
> support for distros with systemd). But I bet actually at least ipv6
> can be a loadable module here, I'll take a look.

Here's a fix that should help quite a bit with ipv6 as a loadable module.

Regards,

Tony

8< ---------------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 27 Oct 2014 09:00:21 -0700
Subject: [PATCH] ARM: omap2plus_defconfig: Fix bloat caused by having ipv6 built-in

Commit  673ce00c5d6c (ARM: omap2plus_defconfig: Add support for
distros with systemd) caused considerable bloat as noted by
Paul Walmsley <paul@pwsan.com>.

Let's fix this issue by making what we can into loadable modules
for the systemd options. That's only IPV6 and AUTOFS4_FS it
seems, and IPv6 defaults to a loadable module.

Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 16e719c..3fbad5b 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -86,7 +86,6 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_LRO is not set
-CONFIG_IPV6=y
 CONFIG_NETFILTER=y
 CONFIG_CAN=m
 CONFIG_CAN_C_CAN=m
@@ -317,7 +316,7 @@ CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA=y
 CONFIG_QFMT_V2=y
-CONFIG_AUTOFS4_FS=y
+CONFIG_AUTOFS4_FS=m
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
