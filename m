From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 4/7] ASoC: TWL6030: Manual power-up/down sequences
Date: Mon, 28 Sep 2009 14:18:21 +0100
Message-ID: <20090928131821.GC31899@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391E2@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58490 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752223AbZI1NST (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Sep 2009 09:18:19 -0400
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90A391E2@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Sep 25, 2009 at 09:03:08PM -0500, Lopez Cruz, Misael wrote:

> +			/* sync registers updated during power-up sequence */
> +			twl6030_write_reg_cache(codec, TWL6030_REG_NCPCTL,
> +						0x81);
> +			twl6030_write_reg_cache(codec, TWL6030_REG_LDOCTL,
> +						0x45);
> +			twl6030_write_reg_cache(codec, TWL6030_REG_LPPLLCTL,
> +						0x01);

It might be nicer if these were read from the hardware instead of being
set to magic values.  Otherwise this looks OK.
