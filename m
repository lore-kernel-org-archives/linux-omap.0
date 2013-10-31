From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 31 Oct 2013 18:25:22 -0400
Message-ID: <CANacCWz_ahKaACbAHuue1XwaN3gutBA7Z6W+=zWBn8LvLwDM5w@mail.gmail.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:59425 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab3JaWZX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Oct 2013 18:25:23 -0400
Received: by mail-qe0-f54.google.com with SMTP id 1so2186046qec.13
        for <linux-omap@vger.kernel.org>; Thu, 31 Oct 2013 15:25:23 -0700 (PDT)
In-Reply-To: <1383164468-4610-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, joelf@ti.com, gururaja.hebbar@ti.com, balajitk@ti.com, mporter@ti.com, Sekhar Nori <nsekhar@ti.com>, s.neumann@raumfeld.com, Russ Dill <Russ.Dill@ti.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Hi Daniel,

On Wed, Oct 30, 2013 at 4:21 PM, Daniel Mack <zonque@gmail.com> wrote:
[...]
> +
> +static SIMPLE_DEV_PM_OPS(edma_pm_ops, edma_pm_suspend, edma_pm_resume);
> +
>  static struct platform_driver edma_driver = {
>         .driver = {
>                 .name   = "edma",
> +               .pm     = &edma_pm_ops,
>                 .of_match_table = edma_of_ids,
>         },

A while back we discovered a nasty race condition here that had us move the EDMA
PM callbacks to the noirq phase. IIRC the MMC driver was resuming
before the EDMA
driver had a chance to run and that was leading to a deadlock. I am
not sure how to force
this scenario but i do remember spending time debugging this on a
random codebase.
Maybe some else has some better ideas on how to force this race condition...

I think logically it makes sense to have the DMA controllers in any
system resume before
any of the client drivers. Maybe a set of syscore_ops similar to the
timekeeping stuff needs
to be added (in the dmaengine framework?) to get this right.

Regards,
Vaibhav
