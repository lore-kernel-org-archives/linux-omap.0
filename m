From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 3/3] omap: add hwspinlock device
Date: Tue, 19 Oct 2010 23:02:37 +0200
Message-ID: <AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <1287387875-14168-4-git-send-email-ohad@wizery.com> <87r5fmxghm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46408 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691Ab0JSVC5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 17:02:57 -0400
In-Reply-To: <87r5fmxghm.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Simon Que <sque@ti.com>

On Tue, Oct 19, 2010 at 7:03 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>> +postcore_initcall(hwspinlocks_init);
>
> Any reason this needs to be a postcore_initcall? =A0Are there users o=
f
> hwspinlocks this early in boot?

i2c-omap, which is subsys_initcall (the I2C bus is shared between the
A9 and the M3 on some OMAP4 boards).

And to allow early board code to reserve specific hwspinlock numbers
for predefined use-cases, we probably want to be before arch_initcall.

> The I2C  =A0Probaly subsys or even device_initcall
> is more appropriate here.
>
> I would've suspected that any users of hwspinlocks will be dependent =
on
> drivers for the other cores (e.g. syslink) which would likely be
> initialized much later.
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
