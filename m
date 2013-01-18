From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: Re: [PATCH v2 0/5] ARM: OMAP4: Enable AESS IP.
Date: Fri, 18 Jan 2013 15:47:38 +0100
Message-ID: <50F9608A.8060102@ti.com>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32990 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466Ab3AROrt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 09:47:49 -0500
In-Reply-To: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Couss?= =?ISO-8859-1?Q?on?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

Paul, Benoit,

Any comments before I resend the serie with the minor comment for Felipe?

Sebastien

On 01/09/2013 04:03 PM, Sebastien Guiriec wrote:
> v2:
> - Add missing AESS memory banks.
> - Update the serie base on comments related earlier serie:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69853.html
>
> The location of the callback has been updated in order to fit with AESS.
> Some call of PM runtime can be done by ASoC core when AESS is in RET so
> we need to ensure that the additional callback is call on enable
> also in order to have clock correctly stop.
>
> v1:
> ARM: OMAP4: Enable AESS IP.
>
> This patch serie extends the the hwmod HWMOD_EXT_OPT_MAIN_CLK flag for the
> AESS IP. This IP has additional register for Auto Gatting configuration. As
> it is used only for Audio the driver is not always loaded. We can reuse the
> same flag as McPDM to work around the HW problem due to bad reset value of
> AESS Auto gatting configuration register.
>
> If we try to setup and reset AESS during boot time without this serie the
> next clocks will still remain enable.
>
> omapconf abe cfg:
> |--------------------------------------------------------------|
> | ABE        Clock Domain Configuration                        |
> |--------------------------------|-----------------------------|
> | Clock State Transition control | HW-Auto                     |
> | Clock State                    |                             |
> |   ABE_24M_FCLK                 | GATED                       |
> |   ABE_ALWON_32K_CLK            | GATED                       |
> |   ABE_SYSCLK                   | GATED                       |
> |   24M_FCLK                     | GATED                       |
> |   ABE_ICLK2                    | RUNNING                     |
> |   DPLL_ABE_X2_CLK              | RUNNING                     |
> |   PAD_CLKS                     | GATED                       |
> |   SLIMBUS_CLK                  | GATED                       |
> | OPP Divider                    | ABE_CLK = DPLL_ABE_X2_CLK/1 |
> |--------------------------------------------------------------|
>
> Paul Walmsley (3):
>    ARM: OMAP2+: hwmod: add enable_preprogram hook
>    ASoC: TI AESS: add autogating-enable function, callable from
>      architecture code
>    ARM: OMAP4+: AESS: enable internal auto-gating during initial setup
>
> Sebastien Guiriec (2):
>    OMAP4: hwmod data: Enable AESS hwmod device
>    OMAP4: hwmod data: Update AESS data with memory bank area
>
>   arch/arm/mach-omap2/Makefile               |    2 +-
>   arch/arm/mach-omap2/omap_hwmod.c           |   18 ++++++++++
>   arch/arm/mach-omap2/omap_hwmod.h           |    8 +++++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   49 +++++++++++++++++++++++--
>   arch/arm/mach-omap2/omap_hwmod_reset.c     |   52 +++++++++++++++++++++++++++
>   include/sound/aess.h                       |   53 ++++++++++++++++++++++++++++
>   6 files changed, 178 insertions(+), 4 deletions(-)
>   create mode 100644 arch/arm/mach-omap2/omap_hwmod_reset.c
>   create mode 100644 include/sound/aess.h
>

