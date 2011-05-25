From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH V4] OMAP3+: SR Layer Cleanup
Date: Wed, 25 May 2011 12:09:01 +0530
Message-ID: <BANLkTim9MbNxtDm8dsZ9wXGm12u2qjwq-g@mail.gmail.com>
References: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
	<4DD67155.1030705@ti.com>
	<BANLkTi=ufSmtnEkyRFKOpbTAJkcUW1dXYg@mail.gmail.com>
	<4DDB9C05.4090705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:42373 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298Ab1EYGjD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 02:39:03 -0400
Received: by mail-bw0-f47.google.com with SMTP id 5so9756721bwz.34
        for <linux-omap@vger.kernel.org>; Tue, 24 May 2011 23:39:01 -0700 (PDT)
In-Reply-To: <4DDB9C05.4090705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

Hi,

On Tue, May 24, 2011 at 5:22 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 5/23/2011 6:40 AM, Gulati, Shweta wrote:
>>
>> Benoit,
>>
>> On Fri, May 20, 2011 at 7:19 PM, Cousson, Benoit<b-cousson@ti.com> =A0=
wrote:
>>>
>>> Hi Shweta,
>>>
>>> On 5/13/2011 8:27 AM, Gulati, Shweta wrote:
>>>>
>>>> To set sr ntarget values =A0for all volt_domain,
>>>> volt_table is retrieved by doing a look_up of 'vdd_name'
>>>> field from omap_hwmod but voltage domain pointer does not
>>>> belong to omap_hwmod and is not used anywhere else.
>>>> As a part of voltage layer and SR Layer clean up volt
>>>> pointer is removed from omap_hwmod and added in dev
>>>> attributes of SR.
>>>>
>>>> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>>>>
>>>> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
>>>> Acked by: Nishanth Menon<nm@ti.com>
>>>> Cc: Benoit Cousson<b-cousson@ti.com>
>>>> Cc: Paul Walmsley<paul@pwsan.com>
>>>> ---
>>>>
>>>> V4:
>>>> =A0 Fixed comments like checking for NULL pointers
>>>> =A0 and following conventions in naming the instances
>>>> =A0 recommended by Todd Poynor and Benoit Cousson.
>>>
>>> It looks like you missed at least two comments I did on the previou=
s
>>> version
>>> whereas you did agree to fix them.
>>
>> You told me to move smartrefex_xxxx_dev_attr above
>> omap44xx_smartreflex_XXX_hwmod struct,
>
> Just before the struct which is not the case.
Ok will do , just above that struct.
>> which is already in that order and the other thing you suggested was
>> to move .dev_attr before .slaves,
>> that I have not done explaining that, to follow the standard as in a=
ll
>> defined hwmod struct .dev_attr are placed after .slaves.
>
> Could you give some example in the OMAP4 data file?
Benoit, I checked in  OMAP3 data file, So it that in OMAP3 and OMAP4 da=
ta file
the order should be different, what do you suggest?
> In the generic form, you should have opt_clk attribute then dev_attr =
then
> .slaves.
>
> Anyway, do not say you will fix something if you decide not to fix th=
em
> after. Or in case of valid concern, please provide some explanation i=
n the
> cover letter.
Benoit, I did send a mail asking for this concern earlier too, Anyways =
we can
decide order for OMAP3 and OMAP 4data files and I would change that in =
V5.

Thanks.
>
> Regards,
> Benoit
>
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
