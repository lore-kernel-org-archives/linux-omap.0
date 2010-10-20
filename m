From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Wed, 20 Oct 2010 11:18:24 -0700
Message-ID: <87wrpcsp73.fsf@deeprootsystems.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-2-git-send-email-ohad@wizery.com>
	<8739s2xfuk.fsf@deeprootsystems.com>
	<AANLkTinHOOPfke2dJrQ1=+vzsa=0BSQjkX5ai7mwpcF8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44597 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab0JTSSa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 14:18:30 -0400
In-Reply-To: <AANLkTinHOOPfke2dJrQ1=+vzsa=0BSQjkX5ai7mwpcF8@mail.gmail.com>
	(Ohad Ben-Cohen's message of "Wed, 20 Oct 2010 15:00:22 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Simon Que <sque@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Ohad Ben-Cohen <ohad@wizery.com> writes:

> On Tue, Oct 19, 2010 at 7:16 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Ohad Ben-Cohen <ohad@wizery.com> writes:
>>
>>> From: Simon Que <sque@ti.com>
>>>
>>> Add driver for OMAP's Hardware Spinlock module.
>>>
>>> The OMAP Hardware Spinlock module, initially introduced in OMAP4,
>>> provides hardware assistance for synchronization between the
>>> multiple processors in the device (Cortex-A9, Cortex-M3 and
>>> C64x+ DSP).
>>
> ...
>
>>> +config OMAP_HWSPINLOCK
>>> + =C2=A0 =C2=A0 bool "OMAP Hardware Spinlock module"
>>
>> Should be tristate
>
> Agree,
>
>> so it can also be built as a module by default.
>>
>> e.g., when building multi-OMAP kernels, no reason or this to be
>> built-in. =C2=A0It can then be loaded as a module on OMAP4 only.
>
> But considering the current built-in use cases (i2c) we would then
> need to have the relevant MACH_OMAP4_* select OMAP_HWSPINLOCK (only o=
n
> the OMAP4 machines on which the I2C bus is shared).

Yes, that is ok.  At least then it can be tested by default as a module=
=2E

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
