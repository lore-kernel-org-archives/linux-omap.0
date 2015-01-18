From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 1/7] ARM: OMAP2+: Remove unused ti81xx platform init code
Date: Sun, 18 Jan 2015 21:32:33 +0100
Message-ID: <CAALWOA8dSv_nAeme2eX2AZkkofrn7BnC2gLc_81kf_fqtZL18A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:53144 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbbARUcy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Jan 2015 15:32:54 -0500
Received: by mail-wg0-f51.google.com with SMTP id l18so6509076wgh.10
        for <linux-omap@vger.kernel.org>; Sun, 18 Jan 2015 12:32:53 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -82,16 +82,8 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
>   musb_plat.mode = board_data->mode;
>   musb_plat.extvbus = board_data->extvbus;
>
> - if (soc_is_am35xx()) {

Was it intentional that this patch also removed a test for am35xx
(rather than am335x) ?
