From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Tue, 12 Feb 2013 11:36:23 -0300
Message-ID: <CALF0-+U-N3_EZiTtdTuZUiTEpUOhNktfXDG0RMORX1yOA_4Jjg@mail.gmail.com>
References: <510BF3D3.3000304@mimc.co.uk>
	<510BF766.5090608@ti.com>
	<510C19FC.8090906@mimc.co.uk>
	<5111304C.7090706@mimc.co.uk>
	<511134C8.8000008@ti.com>
	<511137CF.1090706@mimc.co.uk>
	<51113C74.4070607@ti.com>
	<51137923.4070301@mimc.co.uk>
	<CALF0-+VQ3CJ+GU+Gp7TFDpzND8K48Q_d2yoEy=Y1TdyD1Nb9kA@mail.gmail.com>
	<51196F07.1020600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:47890 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759654Ab3BLOgY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 09:36:24 -0500
Received: by mail-ia0-f177.google.com with SMTP id k38so125890iah.22
        for <linux-omap@vger.kernel.org>; Tue, 12 Feb 2013 06:36:23 -0800 (PST)
In-Reply-To: <51196F07.1020600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>

Hi Jon

On Mon, Feb 11, 2013 at 7:21 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> This is being call from the mach-omap2/board-generic.c file on boot.
> Where are you suggesting this is called from?
>

I was suggesting this could be called in gpmc_probe_dt() in gpmc.c.
Instead of using for_each_node_by_name() and initialize manually each node,
it should be possibly (perhaps with some ugly hack) to use
of_platform_populate()
to initialize gpmc child devices.

But I'm not exactly sure how this would work.

-- 
    Ezequiel
