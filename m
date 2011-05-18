From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 06/11] OMAP4: PM: VC: fix channel bit
 offset for MPU
Date: Wed, 18 May 2011 06:22:24 -0500
Message-ID: <BANLkTi=3cECBDwFYRmYTxd8XGMd_5jks2w@mail.gmail.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com> <1305695854-9638-7-git-send-email-nm@ti.com>
 <87d3jgwdvv.fsf@ti.com> <BANLkTimGiPSOyQDzoa2im3ewk9NbTjGJjg@mail.gmail.com> <87aaekuv36.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47594 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932670Ab1ERLWr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 07:22:47 -0400
Received: by wwc33 with SMTP id 33so1261940wwc.7
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 04:22:45 -0700 (PDT)
In-Reply-To: <87aaekuv36.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, May 18, 2011 at 06:06, Kevin Hilman <khilman@ti.com> wrote:
> "Menon, Nishanth" <nm@ti.com> writes:
>
> [...]
>
>>>
>>>> to handle this on the fly, add a structure to describe this
>>>> and use the structure for vc44xx mpu definition. use the
>>>> default for rest of the domains.
>>>
>>> IMO, while it makes us generate a few more struct in the data, I th=
ink
>>> it's cleaner to not treat this as an exception. =A0IOW, just define
>>> the channel struct(s) in each data file, so every VC has one associ=
ated
>>> with it. =A0Probably also need a WARN() and graceful failure during=
 init
>>> if a channel doesn't have a channel config defined.
>> ..
>>
>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> ---
>>>> =A0arch/arm/mach-omap2/vc.c =A0 =A0 =A0 =A0 =A0| =A0 35 ++++++++++=
+++++++++----------------
>>>> =A0arch/arm/mach-omap2/vc.h =A0 =A0 =A0 =A0 =A0| =A0 33 ++++++++++=
+++++++++++++++++++++++
>>>> =A0arch/arm/mach-omap2/vc44xx_data.c | =A0 10 ++++++++++
>>>> =A03 files changed, 62 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
>>>> index f8185d2..2add945 100644
>>>> --- a/arch/arm/mach-omap2/vc.c
>>>> +++ b/arch/arm/mach-omap2/vc.c
>> [..]
>>>>
>>>> + =A0 =A0 /* if there is an exception case, use the exception data=
 */
>>>> + =A0 =A0 if (!vc->cfg_ch_data)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 cfg_channel_data =3D &cfg_channel_common=
;
>>>> + =A0 =A0 else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 cfg_channel_data =3D vc->cfg_ch_data;
>>>
>>> Based on the above, =A0this block could be dropped, and...
>>
>> Except I will have to replicate this for OMAP3 and 4 - which is
>> possible.. but replicated data which is needed only during init
>
> Yes, but remember we are trying to keep data separated from code.
> Eventually, much of this data will likely be migrated to the device
> tree, so we want to be sure our data is cleanly separated from code.
>
>> :( did not want vc pointer to contain __initdata pointer (dangling
>> ones after boot)
>
> Yes, so far, we're not using initdata for per-SoC stuff, and there ha=
ve
> been proposals around that. =A0However, moving to device tree will la=
rgely
> solve the per-SoC bloat issues around that.

ok. will post a new rev as soon as I get free.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
