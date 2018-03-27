From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Tue, 27 Mar 2018 13:51:10 -0700
Message-ID: <20180327205110.GI5700@atomide.com>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180326203154.GA9334@amd>
 <20180326231022.vilvxwqkniffk775@earth.universe>
 <20180327204111.GA2254@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180327204111.GA2254@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180327 20:42]:
> But Motorola code seems to do different magic according to modem type,
> so things may not be as easy.
> 
>                 if (pdata->voice_type == VOICE_TYPE_STE) {
>                         /* STE_M570 */
>                         ret = cpcap_audio_reg_write(codec, 2, 0xAE06);
>                         if (rate == 16000)
> 				ret |= cpcap_audio_reg_write(codec, 1, 0x8720);
>                         else
>                                 ret |= cpcap_audio_reg_write(codec, 1, 0x8120);
>                 } else if (pdata->voice_type == VOICE_TYPE_QC) {
>                         /* MDM6600 */
>                         ret = cpcap_audio_reg_write(codec, 2, 0xAE02);
>                         if (rate == 16000) {
>                                 ret |= cpcap_audio_reg_write(codec, 1, 0x6720);
>                         } else {
>                                 ret |= cpcap_audio_reg_write(codec, 1, 0x6120);
>                         }

The parts not related to mdm6600 can be ignored until somebody
gets some device other modems working with mainline kernel.

And if there are any refrerences to W3GLTE, or wrigley, it
supposedly never worked for voice calls and only data.

Regards,

Tony
