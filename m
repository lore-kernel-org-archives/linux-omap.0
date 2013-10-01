From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: omap: edma: add suspend suspend/resume hooks
Date: Tue, 01 Oct 2013 11:42:59 -0700
Message-ID: <87pproj0i4.fsf@linaro.org>
References: <1380635493-31040-1-git-send-email-zonque@gmail.com>
	<1380635493-31040-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:47743 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab3JASnD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Oct 2013 14:43:03 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so7651673pdj.3
        for <linux-omap@vger.kernel.org>; Tue, 01 Oct 2013 11:43:03 -0700 (PDT)
In-Reply-To: <1380635493-31040-2-git-send-email-zonque@gmail.com> (Daniel
	Mack's message of "Tue, 1 Oct 2013 15:51:33 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-omap@vger.kernel.org, s.neumann@raumfeld.com, mporter@ti.com, nsekhar@ti.com, alsa-devel@alsa-project.org, gururaja.hebbar@ti.com, linux-arm-kernel@lists.infradead.org

Daniel Mack <zonque@gmail.com> writes:

> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams.

Please add a little more detail abou why the EDMA loses its context
across suspend/resume (e.g. which power domain(s) its in, and why they
lose context across suspend/resume.

Also, is a full context save necessary every time?  What if no channels
are in use?  Also, is a full restore necessary every time? Are there
cases where the domain doesn't lose context and a restore would not be
necessary?  Often this can be checked by reading register(s) that has a
known power-on reset value.

> The code was shamelessly taken from an ancient BSP tree.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>

[...]

> +static int edma_pm_suspend(struct device *dev)
> +{
> +	int i, j;
> +
> +	pm_runtime_get_sync(dev);
> +
> +	for (i = 0; i < arch_num_cc; i++) {
> +		struct edma *ecc = edma_cc[i];
> +
> +		/* backup channel data */
> +		for (j = 0; j < ecc->num_channels; j++)
> +			ecc->context.ch_map[j] =
> +				edma_read_array(i, EDMA_DCHMAP, j);
> +
> +		/* backup DMA Queue Number */
> +		for (j = 0; j < 8; j++)
> +			ecc->context.que_num[j] =
> +				edma_read_array(i, EDMA_DMAQNUM, j);
> +
> +		/* backup DMA shadow Event Set data */
> +		ecc->context.sh_esr = edma_shadow0_read_array(i, SH_ESR, 0);
> +		ecc->context.sh_esrh = edma_shadow0_read_array(i, SH_ESR, 1);
> +
> +		/* backup DMA Shadow Event Enable Set data */
> +		ecc->context.sh_eesr =
> +			edma_shadow0_read_array(i, SH_EER, 0);
> +		ecc->context.sh_eesrh =
> +			edma_shadow0_read_array(i, SH_EER, 1);
> +
> +		/* backup DMA Shadow Interrupt Enable Set data */
> +		ecc->context.sh_iesr =
> +			edma_shadow0_read_array(i, SH_IER, 0);
> +		ecc->context.sh_iesrh =
> +			edma_shadow0_read_array(i, SH_IER, 1);
> +
> +		ecc->context.que_tc_map = edma_read(i, EDMA_QUETCMAP);
> +
> +		/* backup DMA Queue Priority data */
> +		ecc->context.que_pri = edma_read(i, EDMA_QUEPRI);
> +
> +		/* backup paramset */
> +		for (j = 0; j < ecc->num_slots; j++)
> +			memcpy_fromio(&ecc->context.prm_set[j],
> +				      edmacc_regs_base[i] + PARM_OFFSET(j),
> +				      PARM_SIZE);
> +	}

The actual context save doesn't belong here, it belongs in the
->runtime_suspend callback(), and conversly the context restore belongs
in the ->runtime_resume() callback.

> +	pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}

Kevin
