From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to pass base_address
Date: Thu, 23 Jun 2011 16:30:22 +0530
Message-ID: <BANLkTinia6hMs7UjjoT=qjqgZVM9XL3ggQ@mail.gmail.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D625B05@dbde02.ent.ti.com>
 <BANLkTin6ZShO-fmcA-FOm5f+XdhnR3iLDA@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024D6C27CB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:54961 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759157Ab1FWLAn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 07:00:43 -0400
Received: by mail-fx0-f52.google.com with SMTP id 6so2091045fxm.39
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 04:00:42 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C27CB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Sanjeev,

<snip>
>> >
>> > =A0 =A0 The changes in the patch aren't limited to DSS alone.
>> > =A0 =A0 See updated to hdmi_core_audio_config(),
>> hdmi_wp_audio_config_format(),
>> > =A0 =A0 hdmi_wp_audio_config_dma(), etc.
>> >
>> The changes are related to the HDMI driver which as of this patch is
>> in DSS. You see any concerns ? It is only later that those functions
>> are moved out .
>
> [sp] The subject of mail indicates that changes are meant for DSS.
> =A0 =A0 How are the functions I quoted related to DSS? Unless DSS on =
OMAP4
> =A0 =A0 supports audio...
>
Some of the Audio configuration for HDMI is part of DSS (as of 2.6.40)
, This patch series is precisely to separate the DSS portion from
non-DSS portion of HDMI.
It would be great if you have a look at the 2.6.40 kernel and this
gitorious tree with my patch set to get a fair idea.

>> >>
>> >> - =A0 =A0 r =3D hdmi_read_reg(PLLCTRL_CFG1);
>> >> + =A0 =A0 r =3D hdmi_read_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG=
1);
>> >> =A0 =A0 =A0 r =3D FLD_MOD(r, fmt->regm, 20, 9); /* CFG1_PLL_REGM =
*/
>> >> =A0 =A0 =A0 r =3D FLD_MOD(r, fmt->regn, 8, 1); =A0/* CFG1_PLL_REG=
N */
>> >>
>> >> - =A0 =A0 hdmi_write_reg(PLLCTRL_CFG1, r);
>> >> + =A0 =A0 hdmi_write_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG1, r)=
;
>> >
>> > [sp] hdmi_pll_base(ip_data) is used at many places withing this
>> > =A0 =A0 function. Have you checked if saving the result in a local
>> > =A0 =A0 variable generates any better code than repetitive ADD ope=
ration
>> > =A0 =A0 in the function.
>> >
>> > =A0 =A0 Same comment applies to similar use in other functions
>> > =A0 =A0 modified in this patch.
>> >
>> I had this comment from Tomi as well , Yes in some places it makes
>> sense to have a local variable to save , but then in certain functio=
ns
>> where there are four writes with 3 different base address it doesn't
>> make sense to add 3 variables.
>
> [sp] I don't see base address for the IP changing within the function=
=2E
> =A0 =A0 so a local variable still makes sense - instead of using CPU =
cycles
> =A0 =A0 to do reduntant calculations each time.

I shall make those changes where applicable.
>
>> > [snip]...[snip]
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ,
>> >> HDMI_CORE_DDC_CMD, 0x9, 3, 0);
>> >
>> > [sp] Misplaced "," at beginning of the line.
>> >
>> Not a part of the patch i suppose?
>
> [sp] Actually the + indicates it is very much part of the patch.
> =A0 =A0 Ideally it should be at end of prev line.
> =A0 =A0 [quote]
> =A0 =A0 =A0 =A0/* Clear FIFO */
> =A0 =A0 - =A0REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x9, 3, 0);
> =A0 =A0 + =A0REG_FLD_MOD(hdmi_core_sys_base(ip_data)
> =A0 =A0 + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0, HDMI_C=
ORE_DDC_CMD, 0x9, 3, 0);
> =A0 =A0 [/quote]
>
> ~sanjeev
>



--=20
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
