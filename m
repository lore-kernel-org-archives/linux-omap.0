From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Wed, 20 Oct 2010 15:00:22 +0200
Message-ID: <AANLkTinHOOPfke2dJrQ1=+vzsa=0BSQjkX5ai7mwpcF8@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <1287387875-14168-2-git-send-email-ohad@wizery.com> <8739s2xfuk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8739s2xfuk.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Simon Que <sque@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 19, 2010 at 7:16 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Ohad Ben-Cohen <ohad@wizery.com> writes:
>
>> From: Simon Que <sque@ti.com>
>>
>> Add driver for OMAP's Hardware Spinlock module.
>>
>> The OMAP Hardware Spinlock module, initially introduced in OMAP4,
>> provides hardware assistance for synchronization between the
>> multiple processors in the device (Cortex-A9, Cortex-M3 and
>> C64x+ DSP).
>
=2E..

>> +config OMAP_HWSPINLOCK
>> + =A0 =A0 bool "OMAP Hardware Spinlock module"
>
> Should be tristate

Agree,

> so it can also be built as a module by default.
>
> e.g., when building multi-OMAP kernels, no reason or this to be
> built-in. =A0It can then be loaded as a module on OMAP4 only.

But considering the current built-in use cases (i2c) we would then
need to have the relevant MACH_OMAP4_* select OMAP_HWSPINLOCK (only on
the OMAP4 machines on which the I2C bus is shared).


>
> Kevin
>
