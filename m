From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 04/13 v3] OMAP: GPIO: Introduce support for OMAP15xx chip GPIO init
Date: Thu, 17 Jun 2010 13:23:51 -0700
Message-ID: <87hbl1mmqw.fsf@deeprootsystems.com>
References: <1276614348-5201-1-git-send-email-charu@ti.com>
	<1276614348-5201-2-git-send-email-charu@ti.com>
	<1276614348-5201-3-git-send-email-charu@ti.com>
	<1276614348-5201-4-git-send-email-charu@ti.com>
	<1276614348-5201-5-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44990 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289Ab0FQUZn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 16:25:43 -0400
Received: by pwi1 with SMTP id 1so139714pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 13:25:42 -0700 (PDT)
In-Reply-To: <1276614348-5201-5-git-send-email-charu@ti.com> (Charulatha Varadarajan's message of "Tue\, 15 Jun 2010 20\:35\:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: david-b@pacbell.net, broonie@opensource.wolfsonmicro.com, akpm@linux-foundation.org, linux-omap@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, tony@atomide.com

"Varadarajan, Charulatha" <charu@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> This patch adds support for handling OMAP15xx specific gpio_init
> by providing platform device data and doing device registration.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/mach-omap1/gpio15xx.c |  102 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 102 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/gpio15xx.c
>
> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
> new file mode 100644
> index 0000000..e4f1738
> --- /dev/null
> +++ b/arch/arm/mach-omap1/gpio15xx.c
> @@ -0,0 +1,102 @@
> +/*
> + * gpio15xx.c - OMAP15XX-specific gpio code

Minor detail, but you don't need the filename here.

Kevin
