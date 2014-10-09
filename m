From: Archit Taneja <archit.taneja@gmail.com>
Subject: Re: [RFC PATCH 1/6] ARM: OMAP2+: hwmod: add parent_hwmod support
Date: Thu, 9 Oct 2014 22:36:07 +0530
Message-ID: <CAD_+KCGN9gHHRup6bbQUH4yWeycOUDnsnX8JNG=U+GzFNAA-KQ@mail.gmail.com>
References: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
	<1412863399-9508-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:46898 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbaJIRGJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2014 13:06:09 -0400
Received: by mail-lb0-f170.google.com with SMTP id u10so1591915lbd.29
        for <linux-omap@vger.kernel.org>; Thu, 09 Oct 2014 10:06:08 -0700 (PDT)
In-Reply-To: <1412863399-9508-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Tero Kristo <t-kristo@ti.com>

Hi,

On Thu, Oct 9, 2014 at 7:33 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Add parent_hwmod pointer to omap_hwmod. This can be set to point to a
> "parent" hwmod that needs to be enabled for the "child" hwmod to work.
>
> This is used at hwmod setup time: when doing the initial setup and
> reset, first enable the parent hwmod, and after setup and reset is done,
> restore the parent hwmod to postsetup_state.
>

This method is better. It's less intrusive and only takes place at setup time.

Reviewed-by: Archit Taneja <archit.taneja@gmail.com>
