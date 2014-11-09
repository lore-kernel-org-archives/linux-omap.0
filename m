From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 05/11] ARM: dts: omap3-igep00x0: Move outside common file
 the on board Wifi module.
Date: Sun, 9 Nov 2014 11:05:29 +0100
Message-ID: <CABxcv==5N+EQnvqC9UmrKKO8MtADVNcR4Go_nf1kHD3kb6J8jA@mail.gmail.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
	<1415275311-6857-6-git-send-email-eballetbo@iseebcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:51249 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbaKIKFa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Nov 2014 05:05:30 -0500
Received: by mail-wi0-f173.google.com with SMTP id n3so8015235wiv.0
        for <linux-omap@vger.kernel.org>; Sun, 09 Nov 2014 02:05:29 -0800 (PST)
In-Reply-To: <1415275311-6857-6-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hello Enric,

On Thu, Nov 6, 2014 at 1:01 PM, Enric Balletbo i Serra
<eballetbo@iseebcn.com> wrote:
> New IGEP boards revisions will use another Wifi module, so this patch moves
> the DT nodes outside the common omap3-igep.dtsi file to specific DT for every
> board.
>
> Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
