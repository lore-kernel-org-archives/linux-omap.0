From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] pinctrl: single: omap: Add SoC specific module for
 wake-up events
Date: Tue, 23 Jul 2013 00:03:01 +0200
Message-ID: <CACRpkda-2HBkHP+ewkvMH5MV1GxEuXxS_nYEiDdgKtnoyTJpuQ@mail.gmail.com>
References: <20130607203936.16513.57494.stgit@localhost>
	<20130607205044.16513.27675.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:62865 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab3GVWDE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 18:03:04 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so9777241oag.16
        for <linux-omap@vger.kernel.org>; Mon, 22 Jul 2013 15:03:02 -0700 (PDT)
In-Reply-To: <20130607205044.16513.27675.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>

On Fri, Jun 7, 2013 at 10:50 PM, Tony Lindgren <tony@atomide.com> wrote:

> +static irqreturn_t pcs_omap_handle_irq(int irq, void *data)
> +{
> +       struct pcs_omap *pcso = data;
> +       struct list_head *pos;
> +       unsigned int wakeirq;
> +
> +       list_for_each(pos, &pcso->wakeirqs) {
> +               struct pcs_reg *pcsoi;
> +               u16 val;
> +
> +               pcsoi = list_entry(pos, struct pcs_reg, node);
> +               wakeirq = pcsoi->irq;
> +               val = pcsoi->read(pcsoi->reg);
> +               if ((val & OMAP_WAKEUP_EVENT_MASK) == OMAP_WAKEUP_EVENT_MASK)
> +                       generic_handle_irq(wakeirq);
> +       }
> +
> +       if (pcso->reconfigure_io_chain)
> +               pcso->reconfigure_io_chain();
> +
> +       return IRQ_HANDLED;
> +}

I fail to see why this is OMAP-specific.

I would prefer that this gets handled directly in the pinctrl core or
atleast in pinctrl-single in a generic way - latent IRQs is a generic
problem.

And I would also like it to work the other way around: when
irq_set_wake() is called from the irqchip it percolates down
to the pinctrl core and sets up a cross reference like this, for the pin,
so when an IRQ like this occurs, it will be routed up if and only
if it has been flagged as a wakeup from the irqchip layer.

The cross reference can be stored in struct pin_desc.

Yours,
Linus Walleij
