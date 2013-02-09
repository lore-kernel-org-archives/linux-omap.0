From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Sat, 9 Feb 2013 10:27:02 -0300
Message-ID: <CALF0-+VQ3CJ+GU+Gp7TFDpzND8K48Q_d2yoEy=Y1TdyD1Nb9kA@mail.gmail.com>
References: <510BF3D3.3000304@mimc.co.uk>
	<510BF766.5090608@ti.com>
	<510C19FC.8090906@mimc.co.uk>
	<5111304C.7090706@mimc.co.uk>
	<511134C8.8000008@ti.com>
	<511137CF.1090706@mimc.co.uk>
	<51113C74.4070607@ti.com>
	<51137923.4070301@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:61866 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab3BIN1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 08:27:03 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so6246855ieb.29
        for <linux-omap@vger.kernel.org>; Sat, 09 Feb 2013 05:27:02 -0800 (PST)
In-Reply-To: <51137923.4070301@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: Jon Hunter <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>

Hi Mark,

On Thu, Feb 7, 2013 at 6:51 AM, Mark Jackson <mpfj-list@mimc.co.uk> wrote:
> Okay ... I have made some progress, but it's not ideal.
>
> Currently I've hacked the GPMC DT driver (gpmc_probe_dt(), etc) so it now handles setting up the
> chip selects and timings for NOR devices, e.g.
>
>                 gpmc: gpmc@50000000 {
>                         status = "okay";
>                         ranges = <0 0 0x08000000 0x08000000>;   /* CS0: NOR 16M */
>
>                         nor@0,0 {
>                                 compatible = "spansion,s29gl064n90t", "cfi-flash";
>                                 reg = <0 0 0>;
>                                 bank-width = <2>;
>
>                                 gpmc,sync-clk = <0>;
>                                 gpmc,cs-on = <10>;
>                                 gpmc,cs-rd-off = <150>;
>                                 gpmc,cs-wr-off = <150>;
>                                 gpmc,adv-on = <10>;
>                                 gpmc,adv-rd-off = <10>;
>                                 gpmc,adv-wr-off = <10>;
>                                 gpmc,oe-on = <30>;
>                                 gpmc,oe-off = <150>;
>                                 gpmc,we-on = <30>;
>                                 gpmc,we-off = <150>;
>                                 gpmc,rd-cycle = <150>;
>                                 gpmc,wr-cycle = <150>;
>                                 gpmc,access = <130>;
>                                 gpmc,page-burst-access = <10>;
>                                 gpmc,cycle2cycle-diff = <1>;
>                                 gpmc,cycle2cycle-same = <1>;
>                                 gpmc,cycle2cycle-delay = <10>;
>                                 gpmc,wr-data-mux-bus = <60>;
>                         };
>                 };
>
> But the physmap driver (of_flash_probe()) is unable to use this information.  It seems that although
> I can call of_flash_probe() from my NOR setup code, the platform_device being reference is wrong.
>
> The platform_device passed to my gpmc_probe_nor_child() routine from gpmc_probe_dt() points to my
> gpmc entry (above), but the physmap probe requires its own DT entry (rather than a node child such
> as my NOR entry with the GPMC device entry).
>

I think you can call something like:

of_platform_populate();

On your GPMC node and have the child initialize.
This way you don't need to have separate cfi-flash compatible nodes,
you can have them as childs.

Although I'm not sure this is a sane approach, I'm almost sure this should work.

-- 
    Ezequiel
