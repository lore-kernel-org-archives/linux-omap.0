From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 01/11] ARM: dts: omap3-igep00x0: Fix UART2 pins that
 aren't common.
Date: Sat, 8 Nov 2014 21:32:49 +0100
Message-ID: <CABxcv==J_uFRe-47GH9-6GS5PafwOnnkDhTALhHCxRjy4LKFtw@mail.gmail.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
	<1415275311-6857-2-git-send-email-eballetbo@iseebcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:63417 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbaKHUcv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Nov 2014 15:32:51 -0500
Received: by mail-wi0-f182.google.com with SMTP id d1so7281883wiv.15
        for <linux-omap@vger.kernel.org>; Sat, 08 Nov 2014 12:32:49 -0800 (PST)
In-Reply-To: <1415275311-6857-2-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hello Enric,

On Thu, Nov 6, 2014 at 1:01 PM, Enric Balletbo i Serra
<eballetbo@iseebcn.com> wrote:
> UART2 is used to connect the processor with the bluetooth chip, these pins
> are not common between IGEPv2 boards and IGEP COM MODULE boards. This patch
> muxes the correct pins for every board and removes UART2 configuration from
> common omap3-igep.dtsi file.

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
