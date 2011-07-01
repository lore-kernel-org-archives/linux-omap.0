From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 0/8] HDMI: Split hdmi.c to seperate HDMI IP dependant code
 from DSS.
Date: Fri, 1 Jul 2011 18:13:03 +0530
Message-ID: <BANLkTikQ2H4aO=fLx91Lcd5_HrqMRt2=9w@mail.gmail.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308823101.1834.79.camel@deskari> <BANLkTinc9JUr-gBGSynzMtrqTVncDUbNKQ@mail.gmail.com>
 <1308832274.1834.109.camel@deskari> <BANLkTik1TYgaGBYKqYxih1RjPKn8nU_cAA@mail.gmail.com>
 <1309179518.1813.38.camel@lappyti> <BANLkTi=VAaTf7SwXJikHAJGmxJLmbg84Dw@mail.gmail.com>
 <1309364515.20494.20.camel@deskari> <BANLkTi=XUVEXxw7Ag23BEBw8zHY6J+c9OQ@mail.gmail.com>
 <1309510269.1821.18.camel@deskari> <BANLkTik+0P1ycGpS-xU1Utu2Zfzk17ZkWA@mail.gmail.com>
 <1309520677.1821.43.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:58814 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755010Ab1GAMnZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 08:43:25 -0400
Received: by fxg11 with SMTP id 11so3574634fxg.34
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 05:43:23 -0700 (PDT)
In-Reply-To: <1309520677.1821.43.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

On Fri, Jul 1, 2011 at 5:14 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Fri, 2011-07-01 at 14:52 +0530, K, Mythri P wrote:
>
>> > I don't see a need for a separate file right now. We have the
>> > hdmi_ti_4xxx_ip.c file which contains code for the HDMI block as a
>> > whole, and could well contain the code that implements the API.
>> >
>> if the hdmi_ti_4xxx_ip.c =A0is handling the configuration then how a=
re
>> we going to handle a scenario where netra uses a different PHY block=
 ,
>
> I wasn't aware that Netra has different HDMI blocks. I understood it'=
s
> the same as on OMAP4.
>
> So they have a different PHY driver, but want to use PLL and core par=
ts
> of OMAP4 HDMI driver?
>
That was precisely what i was trying to explain for last few threads :-=
).
>> you suggest to have a #if in the programming sequence within
>> hdmi_ti_4xxx_ip.c function ?
>
> No, we can't use #ifdefs as the same kernel has to work for both SoCs=
=2E
>
>> Also in future OMAP's when are using the PHY and PLL block from
>> hdmi_ti_4xxx_ip.c , but a different core/video block from
>> hdmi_ti_5xxx_ip.c then how =A0would hdmi_ti_5xxx_ip.c hdmi_enable be
>> able to call the PHY and PLL configuration functions =A0from
>> hdmi_ti_4xxx_ip.c ??
>
> If the different HDMI blocks will be mixed like that, then we need to
> split the blocks to separate files. Otherwise it will get strange if
> OMAP5 HDMI code is calling PLL functions from OMAP4 HDMI code.
>
> And on top of those drivers/libs we would have a higher level driver/=
lib
> for the whole HDMI entity, and this higher level driver would impleme=
nt
> the API being discussed. It would then use the lower level drivers/li=
bs,
> and be used by OMAP/Netra DSS.
>
Splitting that to multiple would be a file overhead , ie creating a
file to just host 2/3 functions.
Also note it is not OMAP5 HDMI code calling OMAP4 HDMI code , It it no
way in relation to OMAP's as such , so these IP drivers be
provisioning for API's , which the intermediate Arbitration lib / file
which can provide the clean handle to user and can handle the sequence
 as to what IP functions should be called.

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
