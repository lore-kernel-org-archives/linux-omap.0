From: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Add support for thumb mode on DT booted N900
Date: Wed, 5 Feb 2014 17:38:54 +0100
Message-ID: <CAHYPw2HX478ZZPfDTKCKSGhVdFc1-G5DszUR4vG+WRgZx=8+dQ@mail.gmail.com>
References: <1391603582-11371-1-git-send-email-sre@debian.org>
 <CAHYPw2Ep9VP6Tem979ewcztdxkHkG8eR_U31U=f5ibsVa5AS4Q@mail.gmail.com> <20140205163117.GA15996@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140205163117.GA15996@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org

2014-02-05 Sebastian Reichel <sre@debian.org>:
> Hi Pali,
>
> On Wed, Feb 05, 2014 at 02:12:56PM +0100, Pali Roh=C3=A1r wrote:
>> 1) Why are you using if (IS_ENABLED(CONFIG_ARM_ERRATA_430973)) inste=
ad #ifdef ?
>
> This is the preferred kernel style as far as I know.
>

Ok.

>> 2) Why do you not write warning or info when omap type is not
>> OMAP2_DEVICE_TYPE_SEC (e.g qemu) ?
>
> I assumed, that the workaround is not needed for this device type.
>

That rx51 secure call must not be called on non secure devices (e.g.
qemu), because it cause kernel crash. So I thought that kernel should
write something like secure call is disabled on that device types.
Kernel code for errata 430973 will update ibe bit for non secure
devices.

> I just added the warning for missing CONFIG_ARM_ERRATA_430973,
> because its very likely a misconfigured kernel.
>
> -- Sebastian

Yes, it can be misconfigured kernel, but if you do not have any thumb
binary (like stock Maemo 5 system), then it is safe and OK.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
