From: Pankaj Jangra <jangra.pankaj9@gmail.com>
Subject: Re: [PATCH] arm/omap: Replace board_ref_clock with enum values
Date: Fri, 28 Sep 2012 07:54:17 +0530
Message-ID: <CADTbHxozV2UyJjWoDaK3acpDxbtDJDOoapiV19w3FSMZUdMtpA@mail.gmail.com>
References: <5063306E.8080200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44369 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab2I1CYS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 22:24:18 -0400
Received: by wgbdr13 with SMTP id dr13so1918234wgb.1
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 19:24:17 -0700 (PDT)
In-Reply-To: <5063306E.8080200@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Narayanan <vikram186@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi,

On Wed, Sep 26, 2012 at 10:12 PM, Vikram Narayanan <vikram186@gmail.com> wrote:
> Use the enum for board_ref_clock from linux/wl12xx.h
>
> Signed-off-by: Vikram Narayanan <vikram186@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> ---
> I'm not subscribed to the list. So please keep me in Cc for the replies.
>
>  arch/arm/mach-omap2/board-omap4panda.c       |    3 +--
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>

Looks good.

Reviewed-by: Pankaj Jangra<jangra.pankaj9@gmail.com>

--
Pankaj Jangra
