From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: PM related problem with dispc controller
Date: Tue, 23 Sep 2008 11:48:03 +0300
Message-ID: <871vzb5juk.fsf@trdhcp146196.ntc.nokia.com>
References: <19F8576C6E063C45BE387C64729E739403CD7C94AF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56932 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbYIWIqV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 04:46:21 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739403CD7C94AF@dbde02.ent.ti.com>
	(ext Hiremath's message of "Tue, 23 Sep 2008 13:41:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: ext arun c <arun.edarath@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

> Thanks,
> Vaibhav Hiremath
> Senior Software Engg.
> Platform Support Products
> Texas Instruments Inc
> Ph: +91-80-25099927
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger=
=2Ekernel.org] On Behalf Of
>> H=C3=B6gander Jouni
>> Sent: Tuesday, September 23, 2008 1:36 PM
>> To: ext arun c
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: PM related problem with dispc controller
>>=20
>> "ext arun c" <arun.edarath@gmail.com> writes:
>>=20
>> > On Tue, Sep 23, 2008 at 2:49 AM, H=C3=B6gander Jouni
>> > <jouni.hogander@nokia.com> wrote:
>> >> Hi,
>> >>
>> >> I'm debugging pm-0 branch with SDP board and seeing lots of dispc
>> >> related error printouts:
>> >>
>> >> / # <4>__ratelimit: 453 callbacks suppressed
>> >> __ratelimit: 453 callbacks suppressed
>> >> <3>omapfb omapfb: irq error status 00e2
>> >> omapfb omapfb: irq error status 00e2
>> >> <3>omapfb omapfb: irq error status 00e2
>> >> omapfb omapfb: irq error status 00e2
>> >> <3>omapfb omapfb: irq error status 00c0
>> >> omapfb omapfb: irq error status 00c0
>> >> <3>omapfb omapfb: irq error status 0062
>> >> omapfb omapfb: irq error status 0062
>> >> <3>omapfb omapfb: irq error status 00c2
>> >> omapfb omapfb: irq error status 00c2
>> >>
>> >> The error bit in all these statuses is "GFXFIFOUNDERFLOW". Is thi=
s
>> >> something that could happen e.g. in a case that mpu wake-up from =
wfi
>> >> takes too long? I mean is there some interrupt that should be ser=
ved
>> >> faster? Or is this taken care by sdma/hw triggering and now sdma =
is
>> >> not capable to fill the fifo for reason or another?
>> >>
>> >> I have cpuidle enabled and it is "forced" to select only C1 or
>> >> C0. This means tha MPU, NEON, CORE and PER are always
>> >> ON/INACTIVE. Display is also on and there is penguin logo on it. =
When
>> >> I see these error messages there is also flickering on the displa=
y.
>> >>
>> >> This far I had found that on mpu wfi something is switched off
>> >> sometimes. I can see that from consumption of SDP board. Sometime=
s
>> >> consumption is much lower on wfi even if the states of domains ar=
e
>> >> same. When this happens, also these omapfb irq errors begin to ha=
ppen.
>> >>
>> >> I can workaround this problem by disabling DSS_ICK AUTOIDLE. Anot=
her
>> >> workaround is to disable hw supervised mode for core_l3_clkdm or
>> >> core_l4_clkdm.
>> >
>> > Try disabling the smart standby feature of DISPC
>>=20
>> Yes, this actually helps. I see this also as a workaround. Is the ca=
se
>> here that L3 domain is entering some sleep state and waking it up
>> takes too long for dispc?
>>=20
>
> I have seen that without ENWAKEUP flag set (1 << 2), DISPC runs into
> sync lost issue.

DSS wakeup is enabled in l-o tree.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
