From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 0/8] HDMI: Split hdmi.c to seperate HDMI IP dependant code
 from DSS.
Date: Thu, 23 Jun 2011 17:35:12 +0530
Message-ID: <BANLkTinc9JUr-gBGSynzMtrqTVncDUbNKQ@mail.gmail.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com> <1308823101.1834.79.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47054 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756339Ab1FWMFd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 08:05:33 -0400
Received: by mail-fx0-f52.google.com with SMTP id 6so1919090fxm.11
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 05:05:32 -0700 (PDT)
In-Reply-To: <1308823101.1834.79.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

On Thu, Jun 23, 2011 at 3:28 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-06-17 at 13:47 +0530, Mythri P K wrote:
>> HDMI IP block is common between TI OMAP4 Procerssor and Netra proces=
sor although
>> the Display subsytem is different. Thus to reuse the code between th=
ese two
>> processors , HDMI IP dependant code is seperated out from hdmi.c and=
 moved to
>> new library file hdmi_ti_4xxx_ip.c which now resides in /drivers/vid=
eo a more
>> generic location out of omap2/dss folder.
>>
>> This patch series does the split and also renames hdmi_omap4_panel.c=
 to
>> hdmi_panel.c as that file has nothing specific to OMAP4 and can be r=
eused for
>> other OMAP family of processors as well.
>
> These comments are based on the branch you have, not to particular
> patches:
>
> include/video/hdmi_ti_4xxx_ip.h:
>
> - This file is in a way the most important one, because it's the publ=
ic
> API of the component. So you should be extra careful with this, and s=
ee
> that everything in it makes sense, and it's clear how it is to be use=
d.
>
> - hdmi_core_hdmi_dvi is defined but not used. Should it be in the
> private header?

 HDMI_HDMI  and HDMI_DVI are used everywhere in hdmi.c and hdmi_ti_4xxx=
_ip.c,
one thing  i could do is to add a patch to used this enumerator
instead of int mode ?

>
> - hdmi_pll_pwr seems to be very low level thing. It requires the user=
 to
> know HW details about the PLL, I don't think it should be visible to =
the
> users. It is used in parameters for hdmi_ti_4xxx_set_pll_pwr(). When =
is
> it supposed to be used? Why is hdmi_ti_4xxx_wp_video_start() not enou=
gh?
>
HDMI has core , PLL and PHY blocks, so user of the ip driver should
configure them separately.

> - The same goes to hdmi_ti_4xxx_pll_program. Who does the PLL
> calculations, omapdss driver? Shouldn't the HDMI driver do it, the PL=
L
> is a HDMI HW thing, not DSS HW? Or if they are defined in the board
> file, and omapdss just gives them to the HDMI driver, I think the dat=
a
> should be somehow passed through omapdss without omapdss actively
> participating in the PLL programming. This would be easy if the HDMI
> would use a platform device/driver model, the data could be passed vi=
a
> the device data.
>
> - If the PLL calculations have to be done by omapdss, couldn't the
> hdmi_pll_info be part of hdmi_config?

hdmi_pll_info would be used only once while configuring (power on) ,
Why would we have to store the pll_info then in hdmi_config?

>
> - Is hdmi_ti_4xxx_phy_off the counterpart of hdmi_ti_4xxx_phy_init? I=
f
> so, the naming could be better to clearly show this. Like init/uninit=
,
> enable/disable, etc.

I shall rename. yes phy_off is counterpart of init , i shall renmane
it to enable ,disable.
>
> - Is the "phy" relevant (from the user's point of view) in
> hdmi_ti_4xxx_phy_init and off? Or could they be just init and uninit?

PHY is a seperate block in HDMI and even from the user point of view
user should be aware of PHY, PLL and core blocks. so phy_init is
relevant.
>
> - Perhaps hdmi_ti_4xxx_basic_configure could be just configure, there=
's
> no advanced configure or similar.
Well, makes sense but this is the init_configuration(default
configuration) is what was intended in the patch.
>
> - is the "wp" important in hdmi_ti_4xxx_wp_video_start?
>
yes wp =3D=3D wrapper , so it would be clear to have a wp_video_Start.

> - read_ti_4xxx_edid() is named differently than the other functions.
>
I shall rename to hdmi_ti_4xxx_read_edid.

> drivers/video/hdmi_ti_4xxx_ip.c:
>
> - EXPORT_SYMBOL(hdmi_ti_4xxx_phy_init); is not below the function.
>
> drivers/video/omap2/dss/hdmi.c:
>
> - hdmi_ti_4xxx_set_pll_pwr() is only called in power_off(), but never
> enabled. I presume the HDMI driver does that internally. That doesn't
> sound like a valid use of the function.

It is enabled in hdmi_ti_4xxx_pll_program called from power on.

>
> - Looking at hdmi_power_on(), I feel that the API of the HDMI driver
> could be simpler. Would it be enough to have just one function to set=
up
> the HDMI, and another to turn the output on?
No , I suppose it is the responsibility of the user of IP driver to
configure PHY , PLL and CORE blocks seperately as we can reuse the PLL
or PHY block in different SOC's as well.

>
> - omapdss_hdmi_display_set_timing() seems to be broken. It just sets
> some variables and calls display_enable().
It sets a variable custom_set , appropriate action will be taken while
configuring timings based on that parameter.
>
> =A0Tomi
>
>
>
--=20
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
