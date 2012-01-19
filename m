From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Thu, 19 Jan 2012 12:34:50 +0100
Message-ID: <CAMsRxf+e38jRcyxESLhYDZ3OL910AQdapZD9P8vWDXfUE34DAA@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
	<4F0B182D.7060507@us.ibm.com>
	<20120109224945.GA23090@mudshark.cambridge.arm.com>
	<CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
	<CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
	<CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
	<CAMsRxfLtLnMiP0ZGr6rNLv-UeLUwOSJ=7do2nezOU5OkOA+MbQ@mail.gmail.com>
	<CACVXFVMbrQGi4Sg9TUPP5Bcc5kzFoX74n=ii4QrDRudbuDHOGg@mail.gmail.com>
	<CAMsRxfJmHkZw2f0A+4FsStJpXk_vrxvDduRcRGkcWpqp8a9m_w@mail.gmail.com>
	<CACVXFVOQNDRs=c8A2YC+WvYAHs5Abbz-QUEe1VJqrj2esFO11g@mail.gmail.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62077 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab2ASLev convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jan 2012 06:34:51 -0500
Received: by vbbfp1 with SMTP id fp1so2661532vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 03:34:51 -0800 (PST)
In-Reply-To: <CACVXFVOQNDRs=c8A2YC+WvYAHs5Abbz-QUEe1VJqrj2esFO11g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

Ok some update on this.
With your .config file + 3.2.0 (Linus) + patch 3, 4, 5, 6, I get a kern=
el that
boots. It does recognize the PMU. However, it still does not count corr=
ectly
and I believe for the same reason.: no interrupts are delivered.

I run a cycle burner program on CPU0, I watch /proc/interrupts.
and then I run  libpfm4 program that does per-cpu monitoring on CPU0 an=
d
print the counts every second:

$ sudo ./syst_count -d 10 -p -c 0 -e cpu_cycles
<press CTRL-C to quit before 10s time limit>
# 1s -----
CPU0   G0  1008129147           cpu_cycles (scaling 0.00%,
ena=3D1000152588, run=3D1000152588)
# 2s -----
CPU0   G0  2016240766           cpu_cycles (scaling 0.00%,
ena=3D2000335693, run=3D2000335693)
# 3s -----
CPU0   G0  3024249265           cpu_cycles (scaling 0.00%,
ena=3D3000427245, run=3D3000427245)
# 4s -----
CPU0   G0  4072779364           cpu_cycles (scaling 0.00%,
ena=3D4040710449, run=3D4040710449)
# 5s -----
CPU0   G0  785954705            cpu_cycles (scaling 0.00%,
ena=3D5040954589, run=3D5040954589)
# 6s -----
CPU0   G0  1803397848           cpu_cycles (scaling 0.00%,
ena=3D6050384520, run=3D6050384520)
# 7s -----

You clearly see that after 4s you've reached the 32-bit limit of the
counter and then you wrap around.
It should show 5 billions or so cycles. Over the entire run, no
arm-pmu interrupt was delivered according
to /proc/interrupts.

I guess you can test the same condition using perf directly, use a
program that burns cycles
for a know duration. Try < 4s and then > 4s. I use 1s vs. 10s and I
expect the count to be
10x larger in the latter test case. If it's not then, interrupts are
not coming in,


On Thu, Jan 19, 2012 at 2:21 AM, Ming Lei <ming.lei@canonical.com> wrot=
e:
> Hi,
>
> On Thu, Jan 19, 2012 at 5:58 AM, stephane eranian
> <eranian@googlemail.com> wrote:
>> Ming,
>>
>> Ok, so I used Linus' tree @
>>
>> It already includes patches #1 and #2. I applied 4-6.
>
> The patch #3 is missed?
>
>> Recompiled but my kernel does not boot, I don't see
>> anything on the serial console. Could be a broken
>
> I don't think that the patches can cause your non boot, you
> can try the linus tree kernel first, then try the patches.
>
>> .config file. Could you send me your .config for Panda?
>
> See the attachment.
>
>>
>> Thanks.
>>
>> On Wed, Jan 18, 2012 at 11:07 AM, Ming Lei <ming.lei@canonical.com> =
wrote:
>>> Hi,
>>>
>>> On Wed, Jan 18, 2012 at 5:54 PM, stephane eranian <eranian@googlema=
il.com>
>>>> Should I use Will's -next tree as the base instead of Linus'?
>>>
>>> Either one is OK. If you use linus tree as base, you need to apply =
the #1 and
>>> #2 patch manually.
>>>
>>>> Given that MARC is shutdown today, would you mind packing those pa=
tches
>>>> into a tarball and sending them to me directly?
>>>
>>> See attachment, which includes the patches from #3 to #6.
>>>
>>>>
>>>> When you mention Will's -next tree, are you talking about:
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-n=
ext/perf
>>>
>>> It is perf/omap4 brach, you can pick up the two patches[1][2] direc=
tly from
>>> the branch.
>>>
>>>
>>> thanks,
>>> --
>>> Ming Lei
>>>
>>> [1], http://git.kernel.org/?p=3Dlinux/kernel/git/will/linux.git;a=3D=
commit;h=3D7924a3eba0766348d6d6a56cbb9873cdbcab0d8c
>>>
>>> [2], http://git.kernel.org/?p=3Dlinux/kernel/git/will/linux.git;a=3D=
commit;h=3Dbde071f005e2dc71378aff69e86b961d8cd7922f
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
