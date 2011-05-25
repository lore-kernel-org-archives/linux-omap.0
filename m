From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 04/11] OMAP4: PM: VC: support
 configuration of i2c clks
Date: Wed, 25 May 2011 11:32:52 -0700
Message-ID: <BANLkTin9OonSwHn3NAynyFJ-puiNGbqt9A@mail.gmail.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com> <1305695854-9638-5-git-send-email-nm@ti.com>
 <87y624xucx.fsf@ti.com> <BANLkTin5f5oz4aTiebmwWrwYCE2W2OLyAA@mail.gmail.com> <87aaeawsou.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:43638 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752184Ab1EYSdR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 14:33:17 -0400
Received: by wwd20 with SMTP id 20so7950244wwd.23
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 11:33:12 -0700 (PDT)
In-Reply-To: <87aaeawsou.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, May 25, 2011 at 11:17, Kevin Hilman <khilman@ti.com> wrote:
> "Menon, Nishanth" <nm@ti.com> writes:
>
>> On Wed, May 18, 2011 at 03:53, Kevin Hilman <khilman@ti.com> wrote:
>>> Nishanth Menon <nm@ti.com> writes:
>>>
>>>> Patch "OMAP2+: voltage: split voltage controller (VC) code into de=
dicated layer"
>>>> splits out the hardcoded value in the code to vc's channel init.
>>>>
>>>> This patch further isolates the configuration to remove out PMIC s=
pecific
>>>> configuration as high and low times are pmic specific.
>>>>
>>>> Values are updated as well based on latest TI analysis done in and=
roid k35
>>>> kernel.
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>
>>> OK, this is a step in the right direction, but IIUC, these values a=
re
>>> sys_clk dependent right? =A0Shouldn't we be calculating these value=
s based
>>> on sys_clk?
>> 3 factors to my knowledge:
>> a) sr clk I believe(I need to grab the relevant internal doc to
>> verify) - factor of sysclk - > board based/in a way pmic based
>> b) =A0factor of board capacitance (similar to i2c bus)
>> c) =A0i2c bus capability of the PMIC itself.
>>
>> hence based it off pmic data..
>
> These are hard-coded constants, that are calculated somehow, or their
> simply pulled out of the air at random. =A0Either way, we need to kno=
w
> *how* they are calculated, and explain it in.
>
> Personaly, I'd prefer that the explanation come in the form of code.
> IOW, functions that calculate the value based on dependent clocks usi=
ng
> whatever the board-specific factors are as inputs.

yep, trying to dig internally to simplify the blackmagic involved.
ideally, I'd like a person to look at the PMIC data sheet and update
relevant params(timing, maybe bus capacitance max) and the rest of the
computation should be automated. it makes bigger sense for us
considering 4460 has a combination of TPS and TWL controlling rails
and we just have one VC I2C config register to configure the common
value.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
