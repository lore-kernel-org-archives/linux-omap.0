From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 3/5] ASoC: omap: Add HA (HEAD acoustics)
 DSP add-on card audio driver for TAO3530
Date: Mon, 28 Apr 2014 20:35:38 +0300
Message-ID: <535E916A.1020200@bitmer.com>
References: <1398687476-10829-1-git-send-email-sr@denx.de>
 <1398687476-10829-3-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1398687476-10829-3-git-send-email-sr@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Roese <sr@denx.de>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
List-Id: linux-omap@vger.kernel.org

On 04/28/2014 03:17 PM, Stefan Roese wrote:
> From: Jarkko Nikula <jarkko.nikula@bitmer.com>
> 
Same authorship and commit log notes here than to 2/5. One important
comment below.

> --- /dev/null
> +++ b/sound/soc/omap/ha-dsp-card.c
> @@ -0,0 +1,307 @@
> +/*
> + * ha-dsp-card.c  --  SoC audio HA-DSP add-on card for TAO-3530
> + *
> + * Author: Jarkko Nikula <jarkko.nikula@bitmer.com>
> + *
> + * Additional changes by:
> + *   Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
> + *   Stefan Roese <sr@denx.de>

Put here Copyright 2011 Head acoustics GmbH.

-- 
Jarkko
