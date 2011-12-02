From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv7 4/7] omap3: add common twl configurations for vdd1 and vdd2
Date: Fri, 02 Dec 2011 15:56:43 -0800
Message-ID: <87k46ejzno.fsf@ti.com>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
	<1322492005-27741-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:55083 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751680Ab1LBX4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 18:56:46 -0500
Received: by mail-iy0-f175.google.com with SMTP id k25so5262798iah.20
        for <linux-omap@vger.kernel.org>; Fri, 02 Dec 2011 15:56:45 -0800 (PST)
In-Reply-To: <1322492005-27741-5-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 28 Nov 2011 16:53:22 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

Tero Kristo <t-kristo@ti.com> writes:

> VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
> to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
> are needed by DVFS.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

[...]

> +static struct regulator_init_data omap3_vdd1 = {
> +	.constraints = {
> +		.name			= "VDD1",
> +		.min_uV			= 600000,
> +		.max_uV			= 1450000,

nit: can you add a bit to the changelog referencing the document where
theses min/max voltage values come from?

Kevin
