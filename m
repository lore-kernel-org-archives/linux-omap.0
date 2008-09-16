From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: Question about timers used in dsp bridge
Date: Tue, 16 Sep 2008 15:27:55 +0300
Message-ID: <87r67k8ed0.fsf@trdhcp146196.ntc.nokia.com>
References: <200809161040.m8GAesjU011517@dbdp31.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:27096 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbYIPM0b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 08:26:31 -0400
In-Reply-To: <200809161040.m8GAesjU011517@dbdp31.itg.ti.com> (ext Ramesh Gupta
	Guntha's message of "Tue, 16 Sep 2008 16:10:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ramesh Gupta Guntha <x0023949@ti.com>
Cc: linux-omap@vger.kernel.org

"ext Ramesh Gupta Guntha" <x0023949@ti.com> writes:

> Hi Jouni,=20
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org=20
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of=20
>> "H=C3=B6gander" Jouni
>> Sent: Tuesday, September 16, 2008 4:02 PM
>> To: linux-omap@vger.kernel.org
>> Subject: Question about timers used in dsp bridge
>>=20
>> Hi,
>>=20
>> Dsp bridge is using gpt5 and gpt6. When loading baseimage:
>>=20
>> cexec.out -T /lib/dsp/baseimage.dof
>>=20
>> both timers are started, but gpt5 is stopped at some point. Gpt6 is
>> left running. Any idea what for these timers are used and why gpt6 i=
s
>> left running?
>
> In Dsp Bridge GPT5 is used as BIOS_CLK and used only while DSP is sta=
rting, this is disabled once the DSP is started.=20
> GPT6 is used for load monitoring purpose by DSP Bridge. GPT6 is
> disabled only if the DSP enters into sleep state i.e. Hibernation.

Thanks for your explanation. Is it entering sleep state itself and
then informing bridge driver about this or is it bridge which asks dsp
to enter hibernation?

>
> Thanks
> Ramesh Gupta G
>
>
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
