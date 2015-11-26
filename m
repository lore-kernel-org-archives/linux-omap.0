From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags"
 entry
Date: Wed, 25 Nov 2015 20:19:21 -0800
Message-ID: <56568849.5080103@gmail.com>
References: <20150713131902.GH26485@atomide.com> <20151123144545.GD24147@pali> <20151125181644.GI2517@atomide.com> <17134653.86P3dFyQKK@wuerfel> <20151125210310.GT2517@atomide.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151125210310.GT2517@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/25/2015 1:03 PM, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [151125 11:50]:
>> On Wednesday 25 November 2015 10:16:44 Tony Lindgren wrote:
>>> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [151123 06:46]:
>>>> On Sunday 22 November 2015 07:51:46 Pavel Machek wrote:
>>>>> On Wed 2015-11-11 17:10:46, Frank Rowand wrote:
>>>>>> Adding devicetree list.
>>>>>>
>>>>>> Thread starts at
>>>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/=
354459.html
>>>>>>
>>>>>> On 11/5/2015 8:17 AM, Tony Lindgren wrote:
>>>>>>> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [151105 03:41]:
>>>>>>>> On Tuesday 13 October 2015 16:37:46 Pali Roh=C3=A1r wrote:
>>>>>>>>> On Monday 12 October 2015 13:45:09 Tony Lindgren wrote:
>>>>>>>>>> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [151012 13:29]:
>>>>>>>>>>> On Monday 12 October 2015 22:16:40 Tony Lindgren wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Pali, any news on posting an updated series with the comme=
nts
>>>>>>>>>>>> addressed in this thread? It seems that we all pretty much=
 agree
>>>>>>>>>>>> what needs to be done.
>>>>>>
>>>>>> I'm not real happy with the concept of patches 4 and 5 in this s=
eries.
>>>>>> My concern is that those two patches are using the FDT as a tran=
sport
>>>>>> mechanism for a binary blob (the atags object).
>>>>>
>>>>> Umm. Ok. Do you have alternative proposal that works for everyone=
?
>>>>>
>>>>> I mean. This discussion was going for quite a long time, and it w=
ould
>>>>> be nice to have some solution... patch proposal... something.
>>>>>                                                                  =
   Pavel
>>>>
>>>> Yes, discussion is going for a long time! So should I spend time f=
or
>>>> adding documentation to my solution (this is last one thing which =
is
>>>> missing)? Or my solution is wrong and somebody else will propose n=
ew?
>>>> I do not want to spend time on something which will be rejected an=
d
>>>> discarded.
>>>
>>> At least I don't have better solutions in mind.
>>
>> I would be happier if we could restrict this as much as possible to =
the
>> boards that need it, as an opt-in. That way it doesn't become an ABI

The feature (in whatever form it takes) should be definitely be highly
restricted and marked as deprecated.

>> for people that don't already rely in this information. How about
>> adding a check the code adds the linux,atags property to do it
>> only for a whitelist of board numbers?
>=20
> Or populate /proc/atags only for the ones that need it from machine
> specific init_early?

This is circling back to the first comment from Russell King where
he suggested a legacy file for the N900 which calls save_atags():

    Are the ATAGs at a fixed address on the N900?  Can that be handled =
in
    some kind of legacy file for the N900 which calls save_atags() on i=
t, so
    we don't end up introducing yet more stuff that we have to maintain=
 into
    the distant future?  If not, what about copying a known working ata=
g
    structure into a legacy file for the N900?

It seems to me that patches 1, 2, 4, and 5 could be replaced by this
approach.

Regards,

=46rank
