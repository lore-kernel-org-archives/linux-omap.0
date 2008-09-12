From: "arun c" <arun.edarath@gmail.com>
Subject: Re: omapfb not working on beagleboard
Date: Fri, 12 Sep 2008 21:43:30 +0530
Message-ID: <c656a4d20809120913i2cf6b2d0i33289ac8b45f76e9@mail.gmail.com>
References: <94a0d4530809120422q1f0aaf67hb3a1422e2e631112@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:37708 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbYILQNc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 12:13:32 -0400
Received: by ti-out-0910.google.com with SMTP id b6so582338tic.23
        for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 09:13:30 -0700 (PDT)
In-Reply-To: <94a0d4530809120422q1f0aaf67hb3a1422e2e631112@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Sep 12, 2008 at 4:52 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> I was getting bad image with the current omapfb on the Beagle Board
> until Mans Rullgard told me to change the bits per pixel to 16.
>
> Is there any reason why it's 24?

As far as I know omapfb doesn't support 24bpp.


> drivers/video/omap/lcd_omap3beagle.c
>
> --
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
