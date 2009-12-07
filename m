From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: DSS2 and power supplies
Date: Mon, 7 Dec 2009 12:27:24 +0200
Message-ID: <6ed0b2680912070227x3bcb9613x88ebdb0b0a7f3f18@mail.gmail.com>
References: <6ed0b2680912040253m3b25950fuf49e6ec75ad13067@mail.gmail.com>
	 <1260175482.2342.49.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:41050 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934864AbZLGK1S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 05:27:18 -0500
Received: by fxm5 with SMTP id 5so4755021fxm.28
        for <linux-omap@vger.kernel.org>; Mon, 07 Dec 2009 02:27:24 -0800 (PST)
In-Reply-To: <1260175482.2342.49.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Dec 7, 2009 at 10:44 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Fri, 2009-12-04 at 11:53 +0100, ext Grazvydas Ignotas wrote:
>> hi,
>>
>> it seems DSS block in OMAP needs SDI/DSI supplies to operate properl=
y
>> even with parallel displays, or else it doesn't drive some data line=
s
>> resulting in missing/wrong colors. Take a look at figure 15-1 on OMA=
P3
>> TRM (page 2119 on spruf98d), some dss_data lines are going out of
>> SDI/DSI blocks, which are fed by vdds_sdi and vdds_dsi supplies
>> (vdss_sdi in fig 15-1 seems to be a typo). Those 2 are typically
>> connected to VPLL2 on TWL4030/TPS65950 (see fig. 25-2 on p3482), so
>> that regulator needs to be activated for proper operation (if you ha=
ve
>> a parallel display and a board with TWL4030 you can reproduce this b=
y
>> not enabling VPLL2 in bootloader and kernel; mainline u-boot enables
>> it).
>
> Hmm, this would explain the color errors. Have you seen this on some
> other board than TI's SDP?
>
> To me the fig 15-1 does not tell that the powers are needed. The
> DSS_DATA[] pins do not come from SDI/DSI blocks, but from the main DS=
S
> block. And the pin muxing component is outside also. This of course
> doesn't really prove anything. =3D)

True, but apparently vdds_dsi and/or vdds_sdi are also used to drive
some data lines then (not supplying them produces blue-ish display
with some parts missing). I'm working with pandora board, and I'm sure
VPLL2 is not connected to anything else.

>
>> Right now DSS2 requests vdds_dsi in DSI driver only, any plans to
>> request vdds_dsi/vdds_sdi for parallel displays too?
>
> I didn't have any plans, but if what you said is true, it sure needs =
to
> be added.

Yeah that would be nice.

>
> =A0Tomi
>
> Ps. Adding l-o, as others may be interested also.
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
