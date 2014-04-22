From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 0/2] Fix few omap gpmc regressions when booted with device tree
Date: Tue, 22 Apr 2014 08:55:37 +0200
Message-ID: <CABxcv=nDAp=iDXxVrajELJzEG=hEV3ceMJkUaiFOpe79za+LKA@mail.gmail.com>
References: <1398128080-18903-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:35412 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbaDVGzi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 02:55:38 -0400
Received: by mail-we0-f176.google.com with SMTP id x48so4567165wes.35
        for <linux-omap@vger.kernel.org>; Mon, 21 Apr 2014 23:55:37 -0700 (PDT)
In-Reply-To: <1398128080-18903-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

Hi Tony,

On Tue, Apr 22, 2014 at 2:54 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> Here are two fixes to GPMC issues I've seen. It seems that we have
> few more issues left to solve:
>
> 1. The remap of a device with gpmc_cs_remap seems to fail for
>    a device if it's address specified in the .dts file is
>    different from the address used by the bootloader
>
> 2. There seems to be some timing issues with smc911x where
>    rsync of larger files and apt-get dist-upgrade can produce
>    strange errors. This seems to work reliably when booted in
>    legacy mode.
>

In what board are you having this issue? The smsc911x driver supports
both SMSC's LAN911x and LAN921x families and I see that we have two
.dtsi files with different timings
(arm/boot/dts/omap-gpmc-smsc{911x,9221}.dtsi).

This is only a wild guess, but maybe your board has a smsc LAN921x
chip but is including omap-gpmc-smsc911x.dtsi on its DTS?

> 3. The DT mappings of GPMC devices are wrong for most devices
>    where the ranges property should contain the GPMC partition
>    size (16, 32, 128 or 256 MB), and the reg property for the
>    device should only contain the device IO range. So only NOR
>    should use large values for ranges and IO range, the rest
>    should use the minimum 16 MB range for GPMC partition, and
>    0x4 - 0x20000 for the IO range. And while patching these
>    it makes sense to also unify the GPMC ranges being used for
>    devices.
>
> Pekon, can you take a look at 1 and 2 above?
>
> Then for 3 above, it seems that we cannot safely change
> ranges before 1 and 2 are working reliably. Or else we have
> patch things twice, once to fix the range sizes, then to
> unify the mappings for the range address...
>
> Regards,
>
> Tony
>
> Tony Lindgren (2):
>   ARM: OMAP2+: Fix oops for GPMC free
>   ARM: OMAP2+: Fix GPMC remap for devices using an offset
>

These fixes look good to me.

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

>  arch/arm/mach-omap2/gpmc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> --
> 1.8.1.1
>
