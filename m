From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH] OMAP4460: Hwmod: Add hwmod for thermal sensor
Date: Mon, 25 Jul 2011 17:37:15 +0530
Message-ID: <CAJ6a13YdS-mKz7MJ+U99fSP1kOtc0nf66gEs-=9tVj0CZrJf6w@mail.gmail.com>
References: <1309877932-27202-1-git-send-email-vishwanath.bs@ti.com>
	<alpine.DEB.2.00.1107070328150.30028@utopia.booyaka.com>
	<CAJ6a13brXSxeK82wg86x9gS4=UMAXJaXnR9hPwLzGJrBvh9AOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:53257 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750946Ab1GYMHQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jul 2011 08:07:16 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so4553844iyb.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 05:07:15 -0700 (PDT)
In-Reply-To: <CAJ6a13brXSxeK82wg86x9gS4=UMAXJaXnR9hPwLzGJrBvh9AOg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Thu, Jul 21, 2011 at 8:56 PM, J, KEERTHY <j-keerthy@ti.com> wrote:
> On Thu, Jul 7, 2011 at 2:59 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> Hi
>>
>> On Tue, 5 Jul 2011, Vishwanath BS wrote:
>>
>>> From: Keerthy <j-keerthy@ti.com>
>>>
>>> Patch adds hwmod entry for 4460 thermal sensor module. Thermal sens=
or module
>>> is part of Control module sharing its address space and clocked via=
 Bandgap
>>> Functional Clock. Adding a seperate hwmod entry for thermal sensor =
will
>>> enable thermal sensor driver to manage its clock cleanly using PM r=
untime
>>> interfaces.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> Signed-off-by: Vishwnath BS <vishwanath.bs@ti.com>
>>
>> This needs to be coordinated with Beno=EEt, since he's the maintaine=
r of
>> this file. =A0Since he's away at the moment, this is probably 3.2 ma=
terial.
>>
>
> Hello Paul/Tony,
>
> This hwmod is specific to OMAP4460. When i tried to compile i see tha=
t
> CHIP_IS_OMAP446X is missing. Since this is very much specific to
> OMAP4460 is there another way to differentiate between OMAP4430 and
> OMAP4460?

Hi Paul,

Any inputs on this?

>
>>
>> - Paul
>
>
>
> --
> Regards and Thanks,
> Keerthy
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
