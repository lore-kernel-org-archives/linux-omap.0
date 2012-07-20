From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC 1/4] ARM: OMAP3: cpuidle: Remove unused MPU OSWR support code
Date: Fri, 20 Jul 2012 12:38:26 +0530
Message-ID: <CAMQu2gzHBcYg=nhh1J2dsOGUcKBUj5MBTnJBafUPPo0uxxo7og@mail.gmail.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com> <1342764284-8143-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:47778 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753121Ab2GTHIs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 03:08:48 -0400
Received: by qaeb19 with SMTP id b19so69791qae.18
        for <linux-omap@vger.kernel.org>; Fri, 20 Jul 2012 00:08:46 -0700 (PDT)
In-Reply-To: <1342764284-8143-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, t-kristo@ti.com

On Fri, Jul 20, 2012 at 11:34 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> We do not support MPU OSWR on OMAP3. Get rid of the complex/multiple
> save_state handling in omap_sram_idle() and just use 2 save_state
> definitions
>
With current mainline code, this is indeed true.

> save_state = 1, all logic and memory lost, MPU hits OFF
> save_state = 0, nothing lost, MPU hits CSWR or shallower state
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c    |   35 +++++++++--------------------------
>  arch/arm/mach-omap2/sleep34xx.S |    4 +---
>  2 files changed, 10 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7c7b173..8d96b1f 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -256,19 +256,16 @@ static void omap34xx_save_context(u32 *save)
>
>  static int omap34xx_do_sram_idle(unsigned long save_state)
>  {
> +       /*
> +        * save_state = 1 indicates all logic and memory/cache lost
> +        * save_state = 0 indicates nothing lost
> +        */
Keep the same comment with mention of the MPU
state like
save_state = 1, all logic and memory lost, MPU hits OFF
save_state = 0, nothing lost, MPU hits CSWR or shallower state

Rest of the code looks good.

Regards
santosh
