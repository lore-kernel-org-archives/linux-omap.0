From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Re: [PATCH] ARM: OMAP2+: Add support for thumb mode on DT booted
 N900
Date: Wed, 05 Feb 2014 22:30:52 +0200
Message-ID: <52F29F7C.4080502@gmail.com>
References: <1391603582-11371-1-git-send-email-sre@debian.org> <CAHYPw2Ep9VP6Tem979ewcztdxkHkG8eR_U31U=f5ibsVa5AS4Q@mail.gmail.com> <20140205163117.GA15996@earth.universe> <CAHYPw2HX478ZZPfDTKCKSGhVdFc1-G5DszUR4vG+WRgZx=8+dQ@mail.gmail.com> <20140205171729.GA17974@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140205171729.GA17974@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>, =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org

Hi,

On  5.02.2014 19:17, Sebastian Reichel wrote:
> Hi,
>
> On Wed, Feb 05, 2014 at 05:38:54PM +0100, Pali Roh=E1r wrote:
>>> I assumed, that the workaround is not needed for this device type.
>>
>> That rx51 secure call must not be called on non secure devices (e.g.
>> qemu), because it cause kernel crash. So I thought that kernel shoul=
d
>> write something like secure call is disabled on that device types.
>> Kernel code for errata 430973 will update ibe bit for non secure
>> devices.
>
> Do you see any advantage in having that message?
>

AIUI it will appear only when booting the kernel in "qemu -m rx51...", =
I=20
am not aware of any other non-secure device manifesting itself as RX51.=
=20
So there is little advantage of having that additional message IMO.

>>> I just added the warning for missing CONFIG_ARM_ERRATA_430973,
>>> because its very likely a misconfigured kernel.
>>
>> Yes, it can be misconfigured kernel, but if you do not have any thum=
b
>> binary (like stock Maemo 5 system), then it is safe and OK.
>
> I think running this kernel may also be a potential security
> problem. If I understand it right the ARM core is left in an
> unstable state when you run Thumb code, so this may result in
> funny effects in the kernel?
>
> -- Sebastian
>

In theory having that workaround disabled might be a security problem,=20
but honestly, knowing its nature I don't think it is easily exploitable=
,=20
if at all. The final result when bitten by it is a SIGILL, but in=20
userspace, not in the kernel(assuming the kernel is ARM), and userspace=
=20
runs in totally different mode (nonsecure, nonprivileged) compared to=20
the kernel(nonsecure, privileged) and IIRC every mode has its own set o=
f=20
stack, registers etc. BTW I don't think the kernel itself can be=20
thumb2-compiled for cores with that errata, but I might wrong. Also, as=
=20
Pali noted, the problem appears if and only if there is an userspace=20
binary containing thumb2 code. If all of the userspace is pure ARM,=20
there is no problem. And as the errata workaround has its drawbacks (BT=
B=20
is cleared on every context switch which affects performance), one migh=
t=20
want to not have it enabled. Maybe that warning should be spit only if=20
CONFIG_THUMB2_KERNEL (or whatever the option was) is enabled. Though if=
=20
that option is enabled I'd rather #error during compile time if errata=20
workaround is not enabled, instead of printing a warning while booting =
a=20
system that will crash in a matter of seconds.

Ivo
