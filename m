From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 0/8] HDMI: Split hdmi.c to seperate HDMI IP dependant code
 from DSS.
Date: Fri, 1 Jul 2011 14:52:29 +0530
Message-ID: <BANLkTik+0P1ycGpS-xU1Utu2Zfzk17ZkWA@mail.gmail.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308823101.1834.79.camel@deskari> <BANLkTinc9JUr-gBGSynzMtrqTVncDUbNKQ@mail.gmail.com>
 <1308832274.1834.109.camel@deskari> <BANLkTik1TYgaGBYKqYxih1RjPKn8nU_cAA@mail.gmail.com>
 <1309179518.1813.38.camel@lappyti> <BANLkTi=VAaTf7SwXJikHAJGmxJLmbg84Dw@mail.gmail.com>
 <1309364515.20494.20.camel@deskari> <BANLkTi=XUVEXxw7Ag23BEBw8zHY6J+c9OQ@mail.gmail.com>
 <1309510269.1821.18.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:59192 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755930Ab1GAJWu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 05:22:50 -0400
Received: by mail-fx0-f51.google.com with SMTP id 10so3367016fxh.10
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 02:22:49 -0700 (PDT)
In-Reply-To: <1309510269.1821.18.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

On Fri, Jul 1, 2011 at 2:21 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Thu, 2011-06-30 at 23:16 +0530, K, Mythri P wrote:
>> Hi Tomi,
>>
>> On Wed, Jun 29, 2011 at 9:51 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>> > Hi,
>> >
>> > On Wed, 2011-06-29 at 19:08 +0530, K, Mythri P wrote:
>> >> Hi Tomi,
>> >
>> >> As the HDMI PLL , PHY and video blocks are logical blocks it woul=
d
>> >> make sense to have the API's for all and the DSS HDMI (interface
>> >> driver - user driver) would make a call to configure this in a
>> >> particular sequence to enable HDMI , in case you the call to be
>> >> generic across OMAPS in future then we should i either have a fun=
tion
>> >> in hdmi.c which will do this sequence and will be =A0aware of und=
erlying
>> >> IP , Which doesnt appear to be the solution you prefer but then t=
here
>> >> would be a need to have an intermediate file which would take the
>> >> common API call(function pointer) and then arbitrate between diff=
erent
>> >> IP's based on the make , Is that what you are suggesting ?
>> >
>> > I agree that they are separate blocks, and at some level they need=
 to be
>> > separate with own functions for each. But I don't see why the user=
 needs
>> > to know about it.
>> >
>> > For example, consider OMAP DSI. DSI has protocol, PLL and PHY bloc=
ks,
>> > and the driver has functions to initialize them, use them etc. But=
 the
>> > user of DSI, in this case panel drivers, do not need to know about=
 it,
>> > and the API exported to the panel drivers does not contain any fun=
ctions
>> > related to PLL or PHY. The panel drivers just enable the DSI drive=
r and
>> > use it.
>> >
>> > So I'm still asking: what benefit does it give to the user that th=
e API
>> > has functions to handle the blocks separately? There has to be a r=
eason
>> > for the functions in the API.
>> >
>> It doesnt give any additional benefit but flexibility to change the
>> blocks (PHY / PLL) indivudally to use a different one.
>
> Right. But this API is not the right place to implement that
> flexibility. If there's no benefit for the user of the API to know ab=
out
> the details of the HW, it's better hidden. The user just wants to use
> the functionality, not know what lies below.
>
>> >> > And it just occurred to me that perhaps our views of the API ar=
e a bit
>> >> > different, and that's why we have differing opinions. I see thi=
s API as
>> >> > something that could be used by OMAP DSS (and equivalent compon=
ents on
>> >> > other SoCs) to use the HDMI HW on OMAP4 and any future OMAPs. A=
nd
>> >> > perhaps you see this API more as an API to use the current HDMI=
 HW in
>> >> > the OMAP4.
>> >>
>> >> Tomi , Yes my Idea of this API is for OMAP and Netra series only =
, I
>> >> am unable to envision a common HDMI API library , in that case it
>> >> would make more sense to have an intermediate file and have funct=
ion
>> >> pointer , which would take common API calls like hdmi_enable ,
>> >> hdmi_avi_confg etc and then arbitrate based on the build. Please =
let
>> >> me know if you have anything else in mind.
>> >
>> > I didn't mean a generic HDMI API either. I meant a TI HDMI API,
>> > currently for OMAP and Netra. But my comments would be valid even =
if the
>> > API would be only OMAP DSS internal.
>> >
>> Neither the HDMI DSS driver should be concerned about these PHY/PLL
>> internal API's nor should the configuration be done in the =A0IP dri=
ver
>> as the IP driver shpuld only provide functionality and should be
>> flexible enough as across OMAP4 and netra itself there is a
>
> What configuration are you referring to? I don't think the user of th=
e
> API (i.e. omapdss) should do any configuration that requires knowledg=
e
> of the underlying HDMI HW.
>
>> possibility of the PHY block being different , so =A0Now the only
>> solution i see is to have a intermediate file , whose job is to
>> provide common API function and based on the CPU switch would be awa=
re
>> of the IP inside and make appropriate call to IP driver , Does this
>> sound like a good approach ?
>
> I don't see a need for a separate file right now. We have the
> hdmi_ti_4xxx_ip.c file which contains code for the HDMI block as a
> whole, and could well contain the code that implements the API.
>
if the hdmi_ti_4xxx_ip.c  is handling the configuration then how are
we going to handle a scenario where netra uses a different PHY block ,
you suggest to have a #if in the programming sequence within
hdmi_ti_4xxx_ip.c function ?
Also in future OMAP's when are using the PHY and PLL block from
hdmi_ti_4xxx_ip.c , but a different core/video block from
hdmi_ti_5xxx_ip.c then how  would hdmi_ti_5xxx_ip.c hdmi_enable be
able to call the PHY and PLL configuration functions  from
hdmi_ti_4xxx_ip.c ??

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
