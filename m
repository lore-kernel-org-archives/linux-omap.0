From: "Guiriec, Sebastien" <s-guiriec@ti.com>
Subject: Re: [alsa-devel] [PATCH v4 - resend 00/13] OMAP4: ASoC: Support for
 PandaBoard family
Date: Fri, 27 Jan 2012 23:51:39 +0100
Message-ID: <CAAURCh7u=3KLNKfK_YYkVJ_i8azQ=oV0ugVxYvi=thhoLdGEJQ@mail.gmail.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
	<CAJe_Zhfn3urdXfRgAKvdW2_ECYGbNO0b2BuZnCZxrGcL4_sVSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:46549 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1751419Ab2A0Wvl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jan 2012 17:51:41 -0500
Received: by mail-vw0-f47.google.com with SMTP id l22so1647739vbn.6
        for <linux-omap@vger.kernel.org>; Fri, 27 Jan 2012 14:51:39 -0800 (PST)
In-Reply-To: <CAJe_Zhfn3urdXfRgAKvdW2_ECYGbNO0b2BuZnCZxrGcL4_sVSg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

On 01/25/2012 11:50 AM, Jassi Brar wrote:
> On 24 January 2012 17:22, Peter Ujfalusi<peter.ujfalusi@ti.com>  wrote:
>> Hello,
>>
>> the following series will add ASoC support for PandaBoards.
>> PandaBoards have different audio routings compared to SDP4430/Blaze boards, but
>> the differences not that big to justify a new ASoC machine driver.
>>
>> The v3 series did not made it to 3.3 kernel.
>> This set contains all the patches needed to enable the audio support on the
>> PandaBoard family.
>> The machine driver has been converted to a generic OMAP4 driver which can
>> support wide range of machines using OMAP4 with twl6040 codec.
>>
>> I have remove the hardcoded MCLK clock frequency use in the machine driver
>> (there can be devices with different MCLK configuration). This changed
>> patch 04, 05, and 12. Since this does not affect the functionality I kept the
>> acks for these patches. Patch 11 did not existed in the v3 series.
>>
> Hi Peter,
>     I tried the patchset on my 4430 Panda. Playback works ok, but not Capture.
> All is get is a hiss.
>    Is capture supposed to work ? If yes, any amixer settings that need
> to be done?

Hi Jassi,

With the next update the PandaBoard 4430 is working fine.
cpu_is_omap4430() macro is not define. We should use cpu_is_omap443x()
macro in order to select correctly PandaBoard and not PandaBoardES
board. Due to this error the heaset Mic pin is not enable so record is not
working (use for Panda 4430 recording).

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-
omap2/board-omap4panda.c
index 5f27387..6a397e9 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -580,7 +580,7 @@ void omap4_panda_display_init(void)

 static void omap4_panda_init_rev(void)
 {
-	if (cpu_is_omap4430()) {
+	if (cpu_is_omap443x()) {
 		/* PandaBoard 4430 */
 		/* ASoC audio configuration */
 		panda_abe_audio_data.card_name = "PandaBoard";
-- 
1.7.4.1


Sebastien.

>
> Thanks,
> -Jassi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
