From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF and DDR
Date: Mon, 16 Jan 2012 11:15:33 -0800
Message-ID: <CAJOA=zNuVQ9zjhmA5Uc=ksOM2Q7AE4g9ddPDJ3e+QPnUfui4wA@mail.gmail.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
 <4EEFC23A.30201@gmail.com> <20111219233559.GW6464@atomide.com>
 <4EF0671B.7090508@ti.com> <4EF0824A.9060208@ti.com> <4EF096C9.1070808@ti.com>
 <4F09D10B.7010807@ti.com> <CAOesGMjFmM=gXddvFzW+BYqOedySjPVZ6hjwsF-F40Wr9BvSLg@mail.gmail.com>
 <4F1087C9.6030908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:52486 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755760Ab2APTPz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jan 2012 14:15:55 -0500
Received: by mail-iy0-f170.google.com with SMTP id o28so1043230iao.29
        for <linux-omap@vger.kernel.org>; Mon, 16 Jan 2012 11:15:54 -0800 (PST)
In-Reply-To: <4F1087C9.6030908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: Olof Johansson <olof@lixom.net>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robherring2@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vishwanath Sripathy <vishwanath.bs@ti.com>

On Fri, Jan 13, 2012 at 11:36 AM, Aneesh V <aneesh@ti.com> wrote:
> Hi Olof,
>
>
> On Monday 09 January 2012 11:12 AM, Olof Johansson wrote:
>>
>> Hi,
>>
>> On Sun, Jan 8, 2012 at 9:23 AM, Aneesh V<aneesh@ti.com> =A0wrote:
>>>
>>> Hi,
>>>
>>>
>>> On Tuesday 20 December 2011 03:08 PM, Aneesh V wrote:
>>>>
>>>>
>>>> Hi Benoit
>>>>
>>>> On Tuesday 20 December 2011 06:10 PM, Cousson, Benoit wrote:
>>>>>
>>>>>
>>>>> Hi Aneesh,
>>>>>
>>>>
>>>> <snip>
>>>>
>>>>>>>> In general, is it really feasible to parse the DTB before DDR =
is
>>>>>>>> initialized?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Changing timings is still needed for DVFS during runtime.
>>>>>>>
>>>>>>> But we can boot to userspace with bootloader set timings, so I'=
m
>>>>>>
>>>>>>
>>>>>>
>>>>>> As far as I understand, in the current out-of-tree DVFS implemen=
tation
>>>>>> for OMAP, DVFS can start even before user-space.
>>>>>
>>>>>
>>>>>
>>>>> Maybe it is the case, but that does not mean it should.
>>>>> We can potentially delay the DVFS init until the user-space is st=
arted.
>>>>> This should not be considered as a big constraint.
>>
>>
>> Or at least until ramdisk is available, and store the tables there.
>> It's a matter of seconds, delaying DVFS initialization until then
>> shouldn't be the end of the world.
>
>
> It's not about power savings, here is what I understand from
> discussion with power management folks. In our current architecture
> drivers can set frequency constraints with clock framework and this m=
ay
> in turn initiate frequency scaling and this can happen before user
> space. Perhaps we could forbid this too. But I am not sure if the
> benefit is worth the trouble.

Jumping through these kinds of hoops causes me to really question what
it is we're trying to achieve.  There is already the case where clock
event code needs statically allocated clocks for setup before DT data
is available, and in this example at least some subset of mem timings
must be done in bootloader prior to DT data availability again.  Some
times these situations are unavoidable, but I feel uneasy about
splitting data up across multiple sources.  Hunting bugs in such data
is going to be painful.

And delaying DVFS (at least for the parts affecting mem) until
userspace is loaded doesn't seem great to me either.  We're basically
pushing back feature readiness (with respect to boot sequence) in the
name of organizing data in a pretty way... but it's not a pretty
solution since the data will have to be "split" as shown above.

Regards,
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
