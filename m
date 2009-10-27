From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP PM SRF: fix authorship, initial comment
Date: Tue, 27 Oct 2009 14:05:01 -0700
Message-ID: <87tyxk8s5e.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.0910271429160.28412@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:60778 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbZJ0VE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 17:04:59 -0400
Received: by pzk26 with SMTP id 26so96469pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2009 14:05:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0910271429160.28412@utopia.booyaka.com> (Paul Walmsley's message of "Tue\, 27 Oct 2009 14\:30\:12 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com

Paul Walmsley <paul@pwsan.com> writes:

> This patch applies against the PM branch.
>
> While this code is derived from other code that I wrote, I believe this code
> was originally written by Rajendra Nayak.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, pushing to PM branch.  Upon rebase, will fold into initial
addion of SRF.

Kevin


> ---
>  arch/arm/plat-omap/omap-pm-srf.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
> index ef1d235..751d9b3 100644
> --- a/arch/arm/plat-omap/omap-pm-srf.c
> +++ b/arch/arm/plat-omap/omap-pm-srf.c
> @@ -2,14 +2,11 @@
>   * omap-pm-srf.c - OMAP power management interface implemented
>   * using Shared resource framework
>   *
> - * This code implements the OMAP power management interface to
> - * drivers, CPUIdle, CPUFreq, and DSP Bridge.  It is strictly for
> - * debug/demonstration use, as it does nothing but printk() whenever a
> - * function is called (when DEBUG is defined, below)
> + * Copyright (C) 2008-2009 Texas Instruments, Inc.
> + * Copyright (C) 2008-2009 Nokia Corporation
> + * Rajendra Nayak
>   *
> - * Copyright (C) 2008 Texas Instruments, Inc.
> - * Copyright (C) 2008 Nokia Corporation
> - * Paul Walmsley
> + * This code is based on plat-omap/omap-pm-noop.c.
>   *
>   * Interface developed by (in alphabetical order):
>   * Karthik Dasu, Tony Lindgren, Rajendra Nayak, Sakari Poussa, Veeramanikandan
> -- 
> 1.6.5.GIT
