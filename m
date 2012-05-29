From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 03/19] ARM: OMAP4: PM: Add device-off support
Date: Tue, 29 May 2012 11:34:52 -0700
Message-ID: <87aa0qhm43.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-4-git-send-email-t-kristo@ti.com>
	<87obpn92jy.fsf@ti.com> <1337590125.2149.386.camel@sokoban>
	<CAORVsuWrDW-JAHWDNGMGshYxUUqZNURotreO7qW96=6+oKjyAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48742 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754990Ab2E2Sey convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 14:34:54 -0400
Received: by dajz8 with SMTP id z8so8612793daj.16
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 11:34:53 -0700 (PDT)
In-Reply-To: <CAORVsuWrDW-JAHWDNGMGshYxUUqZNURotreO7qW96=6+oKjyAQ@mail.gmail.com>
	(Jean Pihet's message of "Mon, 21 May 2012 16:05:45 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: t-kristo@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Tero, Kevin, Santosh,
>
> On Mon, May 21, 2012 at 10:48 AM, Tero Kristo <t-kristo@ti.com> wrote=
:
>> On Wed, 2012-05-16 at 15:36 -0700, Kevin Hilman wrote:
>>> +Jean for functional power states
>>>
>>> Tero Kristo <t-kristo@ti.com> writes:
>>>
>>> > This patch adds device off support to OMAP4 device type.
>>>
>>> Description is rather thin for a patch that is doing so much.
>>>
>>> > OFF mode is disabled by default,
>>>
>>> why?
>>
>> Good question. For historical reference I guess. The device off work=
s
>> pretty nicely with the current kernel already, so it should be possi=
ble
>> to enable it by default and blame the people who break it.
> Agree. The next problem is 'who will fix the breakage?'.
>
>>> > however, there are two ways to enable OFF mode:
>>> > a) In the board file, call omap4_pm_off_mode_enable(1)
>>> > b) Enable OFF mode using the debugfs entry
>>> > echo "1">/sys/kernel/debug/pm_debug/enable_off_mode
>>> > (conversely echo '0' will disable it as well).
>>>
>>> This part needs to be a separate patch.
>>>
>>> But, as stated in the core retention series, I'd like to move away =
from
>>> these global flags all together.
>>>
>>> The way we manage the disabling of certain states (like off) is alr=
eady
>>> clumsy for OMAP3, and it's getting worse with OMAP4. =C2=A0Basicall=
y, I think
>>> this feature needs to be supported by using constraints on function=
al
>>> power states. =C2=A0 Having checks all over the place is getting un=
wieldy and
>>> not attractive to maintain.
>>>
>>> The combination of constraints and functional power states should m=
ake
>>> this much more manageable. =C2=A0 Until we have that, I'd prefer to=
 keep
>>> the debugfs enable/disable stuff as separate patches at the end of =
the
>>> series used only for testing.
>>
>> Okay, this sounds like a good plan.
>>
>>>
>>> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> > [t-kristo@ti.com: largely re-structured the code]
>>>
>>> then the sign-off above from Santosh probably doesn't apply anymore=
=2E
>>> You should change that to a Cc and just mention tht this is based u=
pon
>>> some original work from Santosh.
>>
>> Yeah... I am not quite sure where the line goes here as I am modifyi=
ng
>> the patches quite heavily but try to keep credits to the original
>> authors... will change this like so.
>>
>>>
>>> First, =C2=A0some general comments:
>>>
>>> There is a lot going on in this patch, so it is hard to follow what=
 all
>>> is related, and why. =C2=A0Just a quick glance suggests it needs to=
 be broken
>>> up into at least a few parts:
>>
>> What is the merge plan for the func power state stuff? I don't want =
to
>> create new dependencies if unnecessary. Otherwise the split should b=
e
>> okay.
> That is something I am interested in too ;p
> I did port and test Tero's patches on top of the functional power
> states, which is the logical approach to me. Now given the reviews
> status on both this patch series and the func power states series I a=
m
> not sure which one needs to be ported on top of the other ;-|
> [1] https://gitorious.org/jpihet/linux-omap/commits/omap4_dev_off
>
> Using the functional power states for the OMAP4 core and device off
> has some advantages in simplifying the code, especially in the
> previous/current/next states checking and programming.

=46or these reasons, I suggest basing this series on top of the functio=
nal
power states series.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
