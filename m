From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 0/8] HDMI: Split hdmi.c to seperate HDMI IP dependant code
 from DSS.
Date: Thu, 30 Jun 2011 23:16:10 +0530
Message-ID: <BANLkTi=XUVEXxw7Ag23BEBw8zHY6J+c9OQ@mail.gmail.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308823101.1834.79.camel@deskari> <BANLkTinc9JUr-gBGSynzMtrqTVncDUbNKQ@mail.gmail.com>
 <1308832274.1834.109.camel@deskari> <BANLkTik1TYgaGBYKqYxih1RjPKn8nU_cAA@mail.gmail.com>
 <1309179518.1813.38.camel@lappyti> <BANLkTi=VAaTf7SwXJikHAJGmxJLmbg84Dw@mail.gmail.com>
 <1309364515.20494.20.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:37949 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753629Ab1F3RrC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 13:47:02 -0400
Received: by fxh10 with SMTP id 10so2759692fxh.24
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 10:46:59 -0700 (PDT)
In-Reply-To: <1309364515.20494.20.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

On Wed, Jun 29, 2011 at 9:51 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> Hi,
>
> On Wed, 2011-06-29 at 19:08 +0530, K, Mythri P wrote:
>> Hi Tomi,
>
>> As the HDMI PLL , PHY and video blocks are logical blocks it would
>> make sense to have the API's for all and the DSS HDMI (interface
>> driver - user driver) would make a call to configure this in a
>> particular sequence to enable HDMI , in case you the call to be
>> generic across OMAPS in future then we should i either have a funtio=
n
>> in hdmi.c which will do this sequence and will be =A0aware of underl=
ying
>> IP , Which doesnt appear to be the solution you prefer but then ther=
e
>> would be a need to have an intermediate file which would take the
>> common API call(function pointer) and then arbitrate between differe=
nt
>> IP's based on the make , Is that what you are suggesting ?
>
> I agree that they are separate blocks, and at some level they need to=
 be
> separate with own functions for each. But I don't see why the user ne=
eds
> to know about it.
>
> For example, consider OMAP DSI. DSI has protocol, PLL and PHY blocks,
> and the driver has functions to initialize them, use them etc. But th=
e
> user of DSI, in this case panel drivers, do not need to know about it=
,
> and the API exported to the panel drivers does not contain any functi=
ons
> related to PLL or PHY. The panel drivers just enable the DSI driver a=
nd
> use it.
>
> So I'm still asking: what benefit does it give to the user that the A=
PI
> has functions to handle the blocks separately? There has to be a reas=
on
> for the functions in the API.
>
It doesnt give any additional benefit but flexibility to change the
blocks (PHY / PLL) indivudally to use a different one.
>> > And it just occurred to me that perhaps our views of the API are a=
 bit
>> > different, and that's why we have differing opinions. I see this A=
PI as
>> > something that could be used by OMAP DSS (and equivalent component=
s on
>> > other SoCs) to use the HDMI HW on OMAP4 and any future OMAPs. And
>> > perhaps you see this API more as an API to use the current HDMI HW=
 in
>> > the OMAP4.
>>
>> Tomi , Yes my Idea of this API is for OMAP and Netra series only , I
>> am unable to envision a common HDMI API library , in that case it
>> would make more sense to have an intermediate file and have function
>> pointer , which would take common API calls like hdmi_enable ,
>> hdmi_avi_confg etc and then arbitrate based on the build. Please let
>> me know if you have anything else in mind.
>
> I didn't mean a generic HDMI API either. I meant a TI HDMI API,
> currently for OMAP and Netra. But my comments would be valid even if =
the
> API would be only OMAP DSS internal.
>
Neither the HDMI DSS driver should be concerned about these PHY/PLL
internal API's nor should the configuration be done in the  IP driver
as the IP driver shpuld only provide functionality and should be
flexible enough as across OMAP4 and netra itself there is a
possibility of the PHY block being different , so  Now the only
solution i see is to have a intermediate file , whose job is to
provide common API function and based on the CPU switch would be aware
of the IP inside and make appropriate call to IP driver , Does this
sound like a good approach ?

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
