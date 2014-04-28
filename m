From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/5] ASoC: Add HA (HEAD acoustics) DSP
	codec driver template
Date: Mon, 28 Apr 2014 20:32:39 +0300
Message-ID: <535E90B7.3050405@bitmer.com>
References: <1398687476-10829-1-git-send-email-sr@denx.de>
 <1398687476-10829-2-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1398687476-10829-2-git-send-email-sr@denx.de>
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

Hi Stefan

On 04/28/2014 03:17 PM, Stefan Roese wrote:
> From: Jarkko Nikula <jarkko.nikula@bitmer.com>
> 
> This codec driver template represents an I2C controlled multichannel audio
> codec that has many typical ASoC codec driver features like volume controls,
> mixer stages, mux selection, output power control, in-codec audio routings,
> codec bias management and DAI link configuration.
> 
I think it's fair to change authorship to you or Thorsten as this is now
more a real codec driver than implementation template I developed
originally a few years back and you have done porting to newer kernel
and API. Plus taking review commits too :-)

> Updates from Stefan Roese, 2014-04-28:
> Port the HA DSP codec driver to Linux v3.15-rc. This includes
> support for DT based probing. No platform-data code is needed
> any more, DT nodes are sufficient.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
> ---
To me it's fine if you write commit log like it was done by you and say
it's based on early implementation template from me. Or something like that.

> diff --git a/sound/soc/codecs/ha-dsp.c b/sound/soc/codecs/ha-dsp.c
> new file mode 100644
> index 0000000..7cf24dc
> --- /dev/null
> +++ b/sound/soc/codecs/ha-dsp.c
> @@ -0,0 +1,419 @@
> +/*
> + * ha-dsp.c  --  HA DSP ALSA SoC Audio driver
> + *
> + * Copyright 2011 Head acoustics GmbH
> + *
> + * Author: Jarkko Nikula <jarkko.nikula@bitmer.com>
> + *
List here also other authors in order to get kudos to you too.

-- 
Jarkko
