From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.19 on Nokia n900: audio quality awful
Date: Fri, 30 Jan 2015 11:26:39 +0100
Message-ID: <20150130102639.GA19595@amd>
References: <20150106170433.GA5408@amd>
 <20150118120139.GA1509@amd>
 <54C63F1C.6010703@ti.com>
 <54C92752.9000004@bitmer.com>
 <20150128224144.GA28956@amd>
 <20150129073529.GA19122@bitmer.com>
 <54CA173F.1070301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54CA173F.1070301@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, lars@metafoo.de, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

Hi!

I looked around the diff between 3.18 and 3.19, reverted these, and
audio quality is back to reasonable level.

commit 68f438378cde79e29f71c7e043b10d76001d8892
Author: Lars-Peter Clausen <lars@metafoo.de>
Date:   Wed Nov 26 20:57:57 2014 +0100

    ASoC: tlv320aic3x: Cleanup manual bias level transitions

    Since the ASoC core now takes care of setting the bias level to
        SND_SOC_BIAS_OFF when removing the CODEC there is no need to
        do it manually
	    anymore.

    Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
        Signed-off-by: Mark Brown <broonie@kernel.org>

commit 68d6626925c3529790a2055d41578415fa98495e
Author: Misael Lopez Cruz <misael.lopez@ti.com>
Date:   Tue Nov 11 10:59:01 2014 +0200

    ASoC: tlv320aic3x: Add output driver pop reduction controls

    Output driver has two parameters that can be configured to reduce
        pop noise: power-on delay and ramp-up step time. Two new
        kcontrols
	    have been added to set these parameters.

    Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
        Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
	    Signed-off-by: Mark Brown <broonie@kernel.org>
	    

commit 368494093354ac613a80c2e1d77602aa12473cf0
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Mon Nov 10 12:27:33 2014 +0200

    ASoC: tlv320aic3x: Add TDM support

    TDM support is achieved using DSP transfer mode and setting a
        programmable offset which specifies where data begins with
	    respect to the frame sync.

    It requires 256-clock mode if CODEC is master (not currently
        supported in the driver). No additional dependency if CODEC
	    is slave.

    Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
        Signed-off-by: Mark Brown <broonie@kernel.org>
	

> diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> index 04896d6252a2..7f299357c2d2 100644
> --- a/sound/soc/omap/rx51.c
> +++ b/sound/soc/omap/rx51.c
> @@ -250,14 +250,14 @@ static const struct snd_soc_dapm_route audio_map[] = {
>  	{"FM Transmitter", NULL, "LLOUT"},
>  	{"FM Transmitter", NULL, "RLOUT"},
> 
> -	{"DMic Rate 64", NULL, "Mic Bias"},
> -	{"Mic Bias", NULL, "DMic"},
> +	{"DMic Rate 64", NULL, "DMic"},
> +	{"DMic", NULL, "Mic Bias"},
> 
>  	{"b LINE2R", NULL, "MONO_LOUT"},
>  	{"Earphone", NULL, "b HPLOUT"},
> 
> -	{"LINE1L", NULL, "b Mic Bias"},
> -	{"b Mic Bias", NULL, "HS Mic"}
> +	{"LINE1L", NULL, "HS Mic"},
> +	{"HS Mic", NULL, "b Mic Bias"},
>  };
> 
>  static const char * const spk_function[] = {"Off", "On"};
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
