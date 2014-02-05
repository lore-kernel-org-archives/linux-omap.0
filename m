From: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Add support for thumb mode on DT booted N900
Date: Wed, 5 Feb 2014 21:42:30 +0100
Message-ID: <CAHYPw2FRbcR_anv9f2igcFV6XnCfpjJMHaeZmcNs8KpXuG96cQ@mail.gmail.com>
References: <1391603582-11371-1-git-send-email-sre@debian.org>
 <CAHYPw2Ep9VP6Tem979ewcztdxkHkG8eR_U31U=f5ibsVa5AS4Q@mail.gmail.com>
 <20140205163117.GA15996@earth.universe> <CAHYPw2HX478ZZPfDTKCKSGhVdFc1-G5DszUR4vG+WRgZx=8+dQ@mail.gmail.com>
 <20140205171729.GA17974@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140205171729.GA17974@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org

2014-02-05 Sebastian Reichel <sre@debian.org>:
> Hi,
>
> On Wed, Feb 05, 2014 at 05:38:54PM +0100, Pali Roh=C3=A1r wrote:
>> > I assumed, that the workaround is not needed for this device type.
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

Consistency. Print message 1) only if secure rx51 smc instruction is
called or 2) print message always (also if smc is not called). With
that patch message is printed (enabled/disabled) only if device is
rx51 and device type is HS.

=46or information it is also good to know that in qemu that special
secure smc instruction was not called.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
