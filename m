From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH V4] OMAP3+: SR Layer Cleanup
Date: Thu, 19 May 2011 15:09:33 +0530
Message-ID: <BANLkTi=BryM-eEsTNcV5E51SnkuZaKsF9Q@mail.gmail.com>
References: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
	<87wrhn9ic2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48168 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932864Ab1ESJjf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 05:39:35 -0400
Received: by bwz10 with SMTP id 10so3064148bwz.24
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 02:39:33 -0700 (PDT)
In-Reply-To: <87wrhn9ic2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Thu, May 19, 2011 at 2:29 PM, Kevin Hilman <khilman@ti.com> wrote:
> Shweta Gulati <shweta.gulati@ti.com> writes:
>
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
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> Acked by: Nishanth Menon <nm@ti.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Paul <paul@pwsan.com>
>
> As this isn't a consolidation/cleanup, I'm not going to push for 2.6.=
40,
> but with an ack from Benoit, I'll queue for 2.6.40+.
>
> Also it has some minor conflicts with some other SR cleanups I have
> queued for 2.6.40+. =A0Please rebase on to my for_2.6.40/pm-misc bran=
ch.
Ok, I will rebase it to 2.6.40/pm-misc branch.
> Thanks,
>
> Kevin
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
