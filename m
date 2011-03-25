From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 2/2] OMAP2+: PANDA: Fix up random or missing MAC addresses for eth0 and wlan0
Date: Fri, 25 Mar 2011 21:20:55 +0100
Message-ID: <201103252120.55417.arnd@arndb.de>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com> <78b7faad4cdc37c6b507c008fde18ef3@mail.gmail.com> <AANLkTineUsH=Qz83YKJy8YZ1KSE1si-RddQ9eBsPjMdk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59563 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1CYUVF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 16:21:05 -0400
In-Reply-To: <AANLkTineUsH=Qz83YKJy8YZ1KSE1si-RddQ9eBsPjMdk@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Kridner <jkridner@beagleboard.org>
Cc: Hema Kalliguddi <hemahk@ti.com>, Andy Green <andy@warmcat.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, David Anders <x0132446@ti.com>, Sebastien Jan <s-jan@ti.com>, tony@atomide.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andy Green <andy.green@linaro.org>

On Friday 25 March 2011 21:13:05 Jason Kridner wrote:
> The use of the OMAP die id below makes this OMAP specific and the list
> referenced below of the devices to be referenced makes it Panda
> specific.  Is there a way to make the list board specific, but to make
> these functions that will be used across many OMAP platforms reusable?
>  I believe that this current code will result in a lot of
> cut-and-paste.  My preference is that this is accepted and that we
> make this more general when we add this to other OMAP platforms, but
> it'd be great to capture your suggestions on how to do so before those
> cut-and-paste patch sets start coming in.
 
Do you know of other existing boards without the EEPROM?
If we need the code to be more general, it will simply have
to move out of the panda specific board file into one file
that can be selected for compilation by other boards.

> >> static void __init omap4_panda_init(void)
> >> {
> >>       int package = OMAP_PACKAGE_CBS;
> >>@@ -517,6 +606,8 @@ static void __init omap4_panda_init(void)
> >>       if (wl12xx_set_platform_data(&omap_panda_wlan_data))
> >>               pr_err("error setting wl12xx data\n");
> >>
> >>+      register_netdevice_notifier(&omap_panda_netdev_notifier);
> >>+
> 
> I just want to make sure I understand how this works.  When a new
> network device is added, if the device name matches one of the above
> listed device paths, then the die id based MAC id is applied.  This
> must be done via a device registration notifier as the registration is
> triggered when the device is detected.

Correct.

	Arnd
