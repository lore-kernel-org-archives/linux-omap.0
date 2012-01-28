From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [alsa-devel] [PATCH v4 - resend 00/13] OMAP4: ASoC: Support for
 PandaBoard family
Date: Sat, 28 Jan 2012 12:19:05 +0530
Message-ID: <CAJe_Zhfo_Z7p4P3Lxj1OyEGWU-EMMRk35qJQ2R1Jwsey9+gOSQ@mail.gmail.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
	<CAJe_Zhfn3urdXfRgAKvdW2_ECYGbNO0b2BuZnCZxrGcL4_sVSg@mail.gmail.com>
	<CAAURCh7u=3KLNKfK_YYkVJ_i8azQ=oV0ugVxYvi=thhoLdGEJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46026 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2A1GtH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Jan 2012 01:49:07 -0500
Received: by wics10 with SMTP id s10so1915419wic.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jan 2012 22:49:05 -0800 (PST)
In-Reply-To: <CAAURCh7u=3KLNKfK_YYkVJ_i8azQ=oV0ugVxYvi=thhoLdGEJQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guiriec, Sebastien" <s-guiriec@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

Hi Sebastien,

On 28 January 2012 04:21, Guiriec, Sebastien <s-guiriec@ti.com> wrote:
>>>
>> Hi Peter,
>> =A0 =A0 I tried the patchset on my 4430 Panda. Playback works ok, bu=
t not Capture.
>> All is get is a hiss.
>> =A0 =A0Is capture supposed to work ? If yes, any amixer settings tha=
t need
>> to be done?
>
> Hi Jassi,
>
> With the next update the PandaBoard 4430 is working fine.
> cpu_is_omap4430() macro is not define. We should use cpu_is_omap443x(=
)
> macro in order to select correctly PandaBoard and not PandaBoardES
> board. Due to this error the heaset Mic pin is not enable so record i=
s not
> working (use for Panda 4430 recording).
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-
> omap2/board-omap4panda.c
> index 5f27387..6a397e9 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -580,7 +580,7 @@ void omap4_panda_display_init(void)
>
> =A0static void omap4_panda_init_rev(void)
> =A0{
> - =A0 =A0 =A0 if (cpu_is_omap4430()) {
> + =A0 =A0 =A0 if (cpu_is_omap443x()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* PandaBoard 4430 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* ASoC audio configuration */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0panda_abe_audio_data.card_name =3D "Pa=
ndaBoard";
>
Thanks, the patch make it work for Panda-4430 too.

Thanks Peter for the amixer settings.

Cheers,
Jassi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
