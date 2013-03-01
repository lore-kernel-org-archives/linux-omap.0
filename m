From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Fri, 1 Mar 2013 18:08:13 -0300
Message-ID: <CALF0-+U6ynTvM0wzBnz2oWDSWQnZ_+1u44Wd-rLL+3qFEt8-2Q@mail.gmail.com>
References: <510BF3D3.3000304@mimc.co.uk>
	<510BF766.5090608@ti.com>
	<510C19FC.8090906@mimc.co.uk>
	<5111304C.7090706@mimc.co.uk>
	<511134C8.8000008@ti.com>
	<511137CF.1090706@mimc.co.uk>
	<51113C74.4070607@ti.com>
	<51137923.4070301@mimc.co.uk>
	<511C007A.7080103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:56754 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab3CAVIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 16:08:14 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so3103422iae.11
        for <linux-omap@vger.kernel.org>; Fri, 01 Mar 2013 13:08:13 -0800 (PST)
In-Reply-To: <511C007A.7080103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>

Hi Jon,

Yet more questions :-) See below...

On Wed, Feb 13, 2013 at 7:07 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>
>
> You don't need this extra entry if you add "simple-bus" to
> the gpmc node compatible string.
>
> +               gpmc: gpmc@6800a000 {
> +                       compatible = "ti,omap2420-gpmc", "simple-bus";
> +                       ti,hwmods = "gpmc";
> +                       reg = <0x6800a000 0x1000>;
> +                       interrupts = <20>;
> +

This "simple-bus" trick is great and very clean!

I'm working on a new driver, similar to gpmc, called device-bus for Marvell SoC.
One remarkable difference is that I need to *setup* the address space
(sort of allocate the address region) for a child device, before I can
access it.

Using simple-bus is a very clean solution. However I'm facing a strange issue:
the child (physmap driver) probe() is being called *before* the parent
(device-bus driver)
probe(), and so the flash device address space cannot get accessed because
it hasn't been setup yet.

Am I doing something wrong? Or is this the expected behavior?

In the latter case, I won't be able to use a compatible "simple-bus"
at all, right?
-- 
    Ezequiel
