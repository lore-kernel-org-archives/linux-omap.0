From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCHv10 00/11] I2C fixes
Date: Sun, 10 Jun 2012 11:10:47 +0530
Message-ID: <CAM=Q2ctZmOFdroUw5qywwGU_4ResB9RKqag4-+qh3nHeKHWzKQ@mail.gmail.com>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
	<87obp4x8gs.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59780 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab2FJFks convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 01:40:48 -0400
In-Reply-To: <87obp4x8gs.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: w.sang@pengutronix.de
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Kevin Hilman <khilman@ti.com>

On Fri, Jun 1, 2012 at 4:29 AM, Kevin Hilman <khilman@ti.com> wrote:
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>
>> The patch series does the following
>>
>> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
>> - In case of i2c remove register access was done without any
>> =A0get_sync fix the same.
>> - Folds a patch from Tasslehoff to prevent any merge conflicts.
>> - Prevents the XDUF flag to be set if the underflow condition is not=
 met.
>> - As per discussion in [1] .Adds a patch to rename the 1p153 errata =
and
>> =A0use the unique id instead as the section number in the recent err=
ata
>> =A0docs has changed.
>>
>> v9:
>> Fix the comments from Wolfram Sang
>>
>> v10:
>> Add a patch from Neil to the series.
>> Fix kevin comments
>> update the patches with comments.
>
> Shubhrajyoti, thanks for the updates.
>
> Wolfgang, with these updates and testing a bit better described, I'm =
OK
> with you merging it. =A0Merging it now will give it plenty of time to
> bake in linux-next and get more test exposure.

Agree,
These are only fixes can it be considered for rc3?

Thanks and Regards,
Shubhrajyoti
>
> Thanks,
>
> Kevin
>
>
>> [1] http://www.spinics.net/lists/linux-i2c/msg07607.html
>>
>> Tested on omap4sdp and omap3sdp.
>> - Did functional tests read write on both the platforms.
>> - Off mode and retention on OMAP3
>> - On OMAP4 just did echo mem > /sys/power/state and wakeup.
>> Did see.
>> [ 1360.595855] Successfully put all powerdomains to target state
>> However didnt see the ret count for other than mpu_pwrdm increase.
>> I think power support for omap4 is minimal.
>>
>> The following changes since commit b48b2c3e50433ff6f7e46186daa7f986b=
d960215:
>>
>> =A0 openrisc: use generic strnlen_user() function (2012-05-27 21:00:=
32 -0700)
>>
>> are available in the git repository at:
>> =A0 git://gitorious.org/linus-tree/linus-tree.git i2c_omap-fixes
>>
>> Neil Brown (1):
>> =A0 =A0 =A0 OMAP/I2C - Fix timeout problem during suspend.
>>
>> Shubhrajyoti D (9):
>> =A0 =A0 =A0 I2C: OMAP: make omap_i2c_unidle/idle functions depend on=
 CONFIG_PM_RUNTIME
>> =A0 =A0 =A0 I2C: OMAP: Fix the mismatch of pm_runtime enable and dis=
able
>> =A0 =A0 =A0 I2C: OMAP: Fix the interrupt clearing in OMAP4
>> =A0 =A0 =A0 I2C: OMAP: Prevent the register access after pm_runtime_=
put in probe
>> =A0 =A0 =A0 I2C: OMAP: Don't check if wait_for_completion_timeout() =
returns less than zero
>> =A0 =A0 =A0 I2C: OMAP: Fix the crash in i2c remove
>> =A0 =A0 =A0 I2C: OMAP: Handle error check for pm runtime
>> =A0 =A0 =A0 I2C: OMAP: Do not set the XUDF(Transmit underflow) if th=
e underflow is not reached
>> =A0 =A0 =A0 I2C: OMAP: Rename the 1p153 to the erratum id i462
>>
>> Tasslehoff Kjappfot (1):
>> =A0 =A0 =A0 I2C: OMAP: prevent the overwrite of the errata flags
>>
>> =A0drivers/i2c/busses/i2c-omap.c | =A0129 ++++++++++++++++++++------=
---------------
>> =A01 files changed, 63 insertions(+), 66 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
