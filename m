From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm_wip/voltdm_nm][PATCH v2 2/3] OMAP4: PM: VC: introduce concept of default channel
Date: Thu, 02 Jun 2011 17:10:19 -0700
Message-ID: <87tyc7lqqc.fsf@ti.com>
References: <1306711180-8631-1-git-send-email-nm@ti.com>
	<1306711180-8631-3-git-send-email-nm@ti.com> <87pqmvn6gk.fsf@ti.com>
	<BANLkTimtJijoVjSX2csi8-MXzGzfbmQfSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56666 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753515Ab1FCAKX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Jun 2011 20:10:23 -0400
Received: by pzk2 with SMTP id 2so729193pzk.37
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 17:10:22 -0700 (PDT)
In-Reply-To: <BANLkTimtJijoVjSX2csi8-MXzGzfbmQfSg@mail.gmail.com> (Nishanth
	Menon's message of "Thu, 2 Jun 2011 18:53:38 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

> On Thu, Jun 2, 2011 at 18:45, Kevin Hilman <khilman@ti.com> wrote:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> Due to a TRM bug, the current code assumes that channel0(core) is t=
he default
>>> channel. With the additional explanation provided by the hardware t=
eam, it is
>>> clear that PRM_VC_CFG_CHANNEL register allows for flexibility of co=
nfiguring
>>> for various PMIC configurations. For example, the I2C slave address=
 on TWL6030
>>> when using 4430 configuration could potentially use the same slave =
address for
>>> all domains, while in 4460 configuration, we drive MPU using TPS; C=
ore and IVA
>>> using TWL6030. To allow this flexibility, we state in existing para=
meters using
>>> a flag to indicate usage of default channel.
>>>
>>> In addition, the TRM update clears up the confusion on the fact tha=
t MPU is
>>> infact the default channel on OMAP4.
>>>
>>> We update the same here.
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>
>> There's too much going on in this patch not described in the changel=
og
>> (extra error checking, volt & cmd reg checking etc.)
>>
>> Also, I don't like the USE_DEFAULT_CHANNEL_I2C_PARAM, mainly because=
 it
>> adds clutter without any obvious value. =C2=A0To me, zero is a perfe=
ctly good
>> value to signify "use default channel value", especially since that'=
s
>> the value used by the hardware.
> The reason is that 0 is a valid i2c register address. 8 bits is used
> in VC and I wanted one bit which was further away, hence the 16 bit.
> The usage could be that in .volt_reg_addr or in .cmd_reg_addr I could
> set this up with the macro. and bingo, we use the default domain's
> configuration.
>
> This is esp useful if we had a single pmic reg for all domains.. I
> mean the VC design allows for it, even though we dont use it
> currently.

OK.

See, it's easy to convince me that something is needed/useful.  Of
course, I prefer to be conviced by the changelog. :) =20

Please make this feature into a dedicated patch with an appropriately
descriptive changelog.  Thanks.

>>
>> Incidentally, adding this doesn't actually change current behavior.
>> Currently, I use zero (an unconfigured value in the VC settings) to
>> signify it should use default settings. =C2=A0In your patch, you def=
ined
>> USE_DEFAULT_CHANNEL_I2C_PARAM as 0x10000 (17 bits) but assign it to =
16
>> bit fields, which means they are just set to zero. :)
>
>
>> So rather than take this patch, I'm just going to fold the following
>> diff into "OMAP3+: VC: abstract out channel configuration" in voltdm=
_b.
>> I'll also update the changelog noting that the TRM is wrong here in =
that
>> it describes CORE as the default channel when it's in fact MPU.
>
> I intend to post a new series including my PMIC changes as well early
> next week(mondayish hopefully). Can we hold off review of any further
> of my voltage fixes patches till then?
>

Sure.  It's the first time anyone as asked me not to review patches. :)
I'll gladly comply.

I've already folded the minimal change I proposed into the original
patch locally, and will push updated voltdm_* branches by the end of
today.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
