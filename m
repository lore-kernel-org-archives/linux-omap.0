From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Tue, 5 Mar 2013 14:43:11 -0300
Message-ID: <CALF0-+WnOWRD=sXNh_2hJutwxzrs22c97jKLiJa8Xjc=xaESpA@mail.gmail.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
	<1361899842-30303-12-git-send-email-jon-hunter@ti.com>
	<51360271.1030302@mimc.co.uk>
	<51360562.20309@ti.com>
	<51361B46.507@mimc.co.uk>
	<51362BAB.10403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36704 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862Ab3CERnM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 12:43:12 -0500
Received: by mail-ie0-f177.google.com with SMTP id 16so7863186iea.8
        for <linux-omap@vger.kernel.org>; Tue, 05 Mar 2013 09:43:11 -0800 (PST)
In-Reply-To: <51362BAB.10403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Mark Jackson <mpfj-list@mimc.co.uk>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Mar 5, 2013 at 2:30 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> This really highlights a weakness in the GPMC driver, particularly
> for NOR, where the child device can only be probed once the parent
> is probed. I don't see this as being DT specific issue, because
> even on older OMAP boards we always registered the NOR flash device
> independently of the GPMC device. So we have always been susceptible to
> this problem AFAICT.
>
> This is admittedly a hack, but I am curious if you add the pinctrl
> properties to the NOR node, if this would also defer the probe on the
> NOR device?
>
> Ideally it would be great to defer the probing of the child until the
> parent has been probed successfully.
>

This seems related to the probing parent-child ordering probing
I pointed out in a previous mail, isn't it?
(which by the way, I'll answer when I can gather some more convincing
feedback).

I don't have OMAP NOR boards, so I'm not entirely familiar to the
way GPMC registers the NOR device. However, by looking
into board-flash.c:board_nor_init() function, it seems to me that:

1. first we request the CS with gpmc_cs_request() and
2. later we register the NOR device explicitly with
    platform_device_register().

So, unless I'm missing something, we force the NOR device
to be probed *after* the GPMC device.

This is definitely the way NAND, OneNAND is handled.

On the otherside, by using 'simple-bus' you create your devices
first, when the whole device-tree is parsed and later the drivers
are probed at module_initcall time.

So, AFAIK, this problem is DT specific.

On the other side, when you say we should defer the probing
of the child. Do you mean changing something in physmap/NAND/etc. drivers?

Please keep in mind, I have nothing against using simple-bus,
since it's a very clean solution. It's just that it seems to me it will
be problematic.
Moreover, the fix shouldn't be too complicated (still working on this).

I'll try to post my Device Bus driver soon (similar to GPMC)
and also I'll try to answer the previous discussion with some
information on why I think this won't work.

(I hope I'm not making too much noise with this)
-- 
    Ezequiel
