From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 3/3] omap: add hwspinlock device
Date: Wed, 20 Oct 2010 16:38:32 +0200
Message-ID: <AANLkTikE1dCXW-7ScVoDgEK3sxai_TyFzstSG+zvNm2F@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <1287387875-14168-4-git-send-email-ohad@wizery.com> <87r5fmxghm.fsf@deeprootsystems.com>
 <AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com> <87bp6pviwf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87bp6pviwf.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Simon Que <sque@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 20, 2010 at 1:53 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>> And to allow early board code to reserve specific hwspinlock numbers
>> for predefined use-cases, we probably want to be before arch_initcall.
>
> There's no reason for board code to have to do this at initcall time.

If we want to have allow both allocations of predefined hwspinlocks
with omap_hwspinlock_request_specific(int), and dynamic allocations
(where we don't care about the specific instance of the hwspinlock we
will get) with omap_hwspinlock_request(), we must ensure that the
former _specific() API will never be called after the latter.

If we will allow drivers to call omap_hwspinlock_request() before all
callers of omap_hwspinlock_request_specific() completed, then things
will break (because drivers might start getting hwspinlocks that are
predefined for dedicated use cases on the system).

So if we want the _specific API to work, we can only allow early board
code to use it in order to reserve those predefined hwspinlocks before
drivers get the chance to call omap_hwspinlock_request().

The tempting alternative is not to provide the
omap_hwspinlock_request_specific() API at all (which is something we
discussed internally).

Let's take the i2c-omap for example.

It sounds like it must have a predefined hwspinlock, but what if:

1. It will use omap_hwspinlock_request() to dynamically allocate a hwspinlock
2. Obviously, the hwspinlock id number must be communicated to the M3
BIOS, so the i2c-omap will publish that id using a small shared memory
entry that will be allocated for this sole purpose
3. we will make sure that 1+2 completes before the remote processor is
taken out of reset

This does not require any smart IPC and it will allow us to get rid of
the omap_hwspinlock_request_specific() API and its early-callers
requirement.

All we will be left to take care of is the order of the ->probe()
execution (assuming we want both the i2c and the hwspinlock drivers to
be device_initcall)

>
> This kind of thing needs to be done by platform_data function pointers,
> as is done for every other driver that needs platform-specific driver
> customization.

Why would we need platform-specific function pointers here ? I'm not
sure I'm following this one.

Thanks,
Ohad.


>
> Kevin
>
