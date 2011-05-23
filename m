From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH V4] OMAP3+: SR Layer Cleanup
Date: Mon, 23 May 2011 10:10:53 +0530
Message-ID: <BANLkTi=ufSmtnEkyRFKOpbTAJkcUW1dXYg@mail.gmail.com>
References: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
	<4DD67155.1030705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:43482 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751466Ab1EWEkz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 May 2011 00:40:55 -0400
Received: by mail-bw0-f47.google.com with SMTP id 5so5006887bwz.6
        for <linux-omap@vger.kernel.org>; Sun, 22 May 2011 21:40:53 -0700 (PDT)
In-Reply-To: <4DD67155.1030705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

Benoit,

On Fri, May 20, 2011 at 7:19 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Hi Shweta,
>
> On 5/13/2011 8:27 AM, Gulati, Shweta wrote:
>>
>> To set sr ntarget values =A0for all volt_domain,
>> volt_table is retrieved by doing a look_up of 'vdd_name'
>> field from omap_hwmod but voltage domain pointer does not
>> belong to omap_hwmod and is not used anywhere else.
>> As a part of voltage layer and SR Layer clean up volt
>> pointer is removed from omap_hwmod and added in dev
>> attributes of SR.
>>
>> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>>
>> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
>> Acked by: Nishanth Menon<nm@ti.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> ---
>>
>> V4:
>> =A0 Fixed comments like checking for NULL pointers
>> =A0 and following conventions in naming the instances
>> =A0 recommended by Todd Poynor and Benoit Cousson.
>
> It looks like you missed at least two comments I did on the previous =
version
> whereas you did agree to fix them.
You told me to move smartrefex_xxxx_dev_attr above
omap44xx_smartreflex_XXX_hwmod struct,
which is already in that order and the other thing you suggested was
to move .dev_attr before .slaves,
that I have not done explaining that, to follow the standard as in all
defined hwmod struct .dev_attr are placed after .slaves.
> Thanks,
> Benoit
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
