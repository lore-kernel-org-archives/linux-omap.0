From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [pm_wip/voltdm_nm][PATCH v2 2/3] OMAP4: PM: VC: introduce concept
 of default channel
Date: Thu, 2 Jun 2011 19:15:53 -0500
Message-ID: <BANLkTimRc5oRjaue8L3jD1-ihomhvq-NJw@mail.gmail.com>
References: <1306711180-8631-1-git-send-email-nm@ti.com> <1306711180-8631-3-git-send-email-nm@ti.com>
 <87pqmvn6gk.fsf@ti.com> <BANLkTimtJijoVjSX2csi8-MXzGzfbmQfSg@mail.gmail.com> <87tyc7lqqc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:34372 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753633Ab1FCAQ3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Jun 2011 20:16:29 -0400
Received: by mail-ww0-f50.google.com with SMTP id 33so1036381wwc.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 17:16:28 -0700 (PDT)
In-Reply-To: <87tyc7lqqc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, Jun 2, 2011 at 19:10, Kevin Hilman <khilman@ti.com> wrote:
> "Menon, Nishanth" <nm@ti.com> writes:
>
>> On Thu, Jun 2, 2011 at 18:45, Kevin Hilman <khilman@ti.com> wrote:
>>> Nishanth Menon <nm@ti.com> writes:
>>>
>>>> Due to a TRM bug, the current code assumes that channel0(core) is =
the default
>>>> channel. With the additional explanation provided by the hardware =
team, it is
>>>> clear that PRM_VC_CFG_CHANNEL register allows for flexibility of c=
onfiguring
>>>> for various PMIC configurations. For example, the I2C slave addres=
s on TWL6030
>>>> when using 4430 configuration could potentially use the same slave=
 address for
>>>> all domains, while in 4460 configuration, we drive MPU using TPS; =
Core and IVA
>>>> using TWL6030. To allow this flexibility, we state in existing par=
ameters using
>>>> a flag to indicate usage of default channel.
>>>>
>>>> In addition, the TRM update clears up the confusion on the fact th=
at MPU is
>>>> infact the default channel on OMAP4.
>>>>
>>>> We update the same here.
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>
>>> There's too much going on in this patch not described in the change=
log
>>> (extra error checking, volt & cmd reg checking etc.)
>>>
>>> Also, I don't like the USE_DEFAULT_CHANNEL_I2C_PARAM, mainly becaus=
e it
>>> adds clutter without any obvious value. =A0To me, zero is a perfect=
ly good
>>> value to signify "use default channel value", especially since that=
's
>>> the value used by the hardware.
>> The reason is that 0 is a valid i2c register address. 8 bits is used
>> in VC and I wanted one bit which was further away, hence the 16 bit.
>> The usage could be that in .volt_reg_addr or in .cmd_reg_addr I coul=
d
>> set this up with the macro. and bingo, we use the default domain's
>> configuration.
>>
>> This is esp useful if we had a single pmic reg for all domains.. I
>> mean the VC design allows for it, even though we dont use it
>> currently.
>
> OK.
>
> See, it's easy to convince me that something is needed/useful. =A0Of
> course, I prefer to be conviced by the changelog. :)
>
> Please make this feature into a dedicated patch with an appropriately
> descriptive changelog. =A0Thanks.

Yes, I agree. it probably is a better idea to break this thing up - I
guess I was a bit lazyish considering these were targetted to be
squashed.. not in the next series :)
>
>>>
>>> Incidentally, adding this doesn't actually change current behavior.
>>> Currently, I use zero (an unconfigured value in the VC settings) to
>>> signify it should use default settings. =A0In your patch, you defin=
ed
>>> USE_DEFAULT_CHANNEL_I2C_PARAM as 0x10000 (17 bits) but assign it to=
 16
>>> bit fields, which means they are just set to zero. :)
>>
>>
>>> So rather than take this patch, I'm just going to fold the followin=
g
>>> diff into "OMAP3+: VC: abstract out channel configuration" in voltd=
m_b.
>>> I'll also update the changelog noting that the TRM is wrong here in=
 that
>>> it describes CORE as the default channel when it's in fact MPU.
>>
>> I intend to post a new series including my PMIC changes as well earl=
y
>> next week(mondayish hopefully). Can we hold off review of any furthe=
r
>> of my voltage fixes patches till then?
>>
>
> Sure. =A0It's the first time anyone as asked me not to review patches=
=2E :)
> I'll gladly comply.
>
> I've already folded the minimal change I proposed into the original
> patch locally, and will push updated voltdm_* branches by the end of
> today.

:) Thanks. I will rework the patches and line up a series from cpufreq
and voltage domain perspective in the upcoming days..

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
