From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Mon, 24 Jun 2013 17:35:18 +0200
Message-ID: <CAAwP0s1LTj1gu8o2mQd3arzH9-9Wfn2G+wsQ=4DpnMRXb7LADw@mail.gmail.com>
References: <20130516180933.GG5600@atomide.com> <20130516210006.GA31836@blackmetal.musicnaut.iki.fi>
 <20130516214430.GN5600@atomide.com> <20130520174621.GI10378@atomide.com>
 <20130605223355.EDC113E10E4@localhost> <20130606155341.GL3331@atomide.com>
 <20130623221605.GA3150@blackmetal.musicnaut.iki.fi> <CAAwP0s1DkMu8Vfka43hS4Wj-927q=O5u-coyFsPBgy3qtA_vjw@mail.gmail.com>
 <20130623234326.GA20703@blackmetal.musicnaut.iki.fi> <CAAwP0s00RwP7jCMF1O8j8Ndhu=VfD2dMA5fzr6jWvQ7PziXBCw@mail.gmail.com>
 <20130624072112.GQ5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:63864 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab3FXPfj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jun 2013 11:35:39 -0400
Received: by mail-ve0-f178.google.com with SMTP id pb11so8859903veb.37
        for <linux-omap@vger.kernel.org>; Mon, 24 Jun 2013 08:35:38 -0700 (PDT)
In-Reply-To: <20130624072112.GQ5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jon Hunter <jgchunter@gmail.com>

On Mon, Jun 24, 2013 at 9:21 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Javier Martinez Canillas <martinez.javier@gmail.com> [130623 18:08]:
>> On Mon, Jun 24, 2013 at 1:43 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> > Hi,
>> >
>> > On Mon, Jun 24, 2013 at 01:06:37AM +0200, Javier Martinez Canillas wrote:
>> >> On Mon, Jun 24, 2013 at 12:16 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> >> > What is the status of this patch? We're already at 3.10-rc7 and GPIO
>> >> > IRQs are still broken on OMAP1.
>> >
>> > [...]
>> >
>> >> There is a problem with this patch.
>> >
>> > [...]
>> >
>> >> So I think that the correct solution is to add SPARSE_IRQ support to
>> >> omap1 and not reverting Jon's patch. Of course this may not be
>> >> possible since we are so close to 3.10 and most OMAP patches already
>> >> merged for 3.11 but we should definitely try to have this at least for
>> >> 3.12. Otherwise we won't be able to move to DT-only booting for
>> >> OMAP2+.
>> >
>> > OMAP1 does not use DT. So we could put this code under #ifdef
>> > CONFIG_ARCH_OMAP1 or similar. It's just a few lines of code. OMAP2+
>> > work should not regress OMAP1.
>> >
>> > Demanding SPARSE_IRQ support for OMAP1 should have been discussed before
>> > these changes were made. It's not reasonable to assume such things can
>> > be made during rc-cycle. Also, now, I don't think it's reasonable to
>> > wait for that to be done, as it would take until 3.12 or even later to
>> > get OMAP1 functional again.
>> >
>> > A.
>>
>> Hi,
>>
>> Yes, since we are so late in the -rc cycle and OMAP1 is currently
>> broken I agree that the only sensible solution is to revert the patch
>> for now.
>
> Agreed.
>
>> I just wanted to point out the issue that keeping the OMAP GPIO driver
>> using legacy mapping domain represents a blocker to have GPIO-IRQ
>> working with Device Tree for OMAP2+
>
> Yes. We can do the ifdef Aaro suggested, and let's also plan on
> converting omap1 to use SPARSE_IRQ. But with the ifdef we can cut
> away the dependency between these two.
>
> Regards,
>
> Tony

Ok, so something like the following patch should do it (tested on an
OMAP3 board):

>From b9e262c688fb7f3ad733f140b55dddbc8e4716e6 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Mon, 24 Jun 2013 17:13:23 +0200
Subject: [PATCH 1/1] gpio/omap: don't use linear domain mapping for OMAP1

commit ede4d7a5 ("gpio/omap: convert gpio irq domain to linear mapping")
converted the OMAP GPIO driver to use a linear mapping for the GPIO IRQ
domain instead of using a legacy mapping. Not using a legacy mapping has
a number of benefits but it requires the platform to support SPARSE_IRQ
which currently is not supported on OMAP1.

So this change caused a regression on OMAP1 platforms [1].

Since this issue is not present on all OMAP2+ platforms, there is no need to
revert the driver to use legacy domain mapping for all the platforms.

[1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg89005.html

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/gpio/gpio-omap.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d3f7d2d..4a43036 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1094,6 +1094,9 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	const struct omap_gpio_platform_data *pdata;
 	struct resource *res;
 	struct gpio_bank *bank;
+#ifdef CONFIG_ARCH_OMAP1
+	int irq_base;
+#endif

 	match = of_match_device(of_match_ptr(omap_gpio_match), dev);

@@ -1135,11 +1138,28 @@ static int omap_gpio_probe(struct platform_device *pdev)
 				pdata->get_context_loss_count;
 	}

+#ifdef CONFIG_ARCH_OMAP1
+	/*
+	 * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
+	 * irq_alloc_descs() and irq_domain_add_legacy() and just use a
+	 * linear IRQ domain mapping for all OMAP platforms.
+	 */
+	irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
+	if (irq_base < 0) {
+		dev_err(dev, "Couldn't allocate IRQ numbers\n");
+		return -ENODEV;
+	}

+	bank->domain = irq_domain_add_legacy(node, bank->width, irq_base,
+					     0, &irq_domain_simple_ops, NULL);
+#else
 	bank->domain = irq_domain_add_linear(node, bank->width,
 					     &irq_domain_simple_ops, NULL);
-	if (!bank->domain)
+#endif
+	if (!bank->domain) {
+		dev_err(dev, "Couldn't register an IRQ domain\n");
 		return -ENODEV;
+	}

 	if (bank->regs->set_dataout && bank->regs->clr_dataout)
 		bank->set_dataout = _set_gpio_dataout_reg;
-- 
1.7.7.6
