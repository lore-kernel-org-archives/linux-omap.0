From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] omap: add hwspinlock device
Date: Tue, 19 Oct 2010 16:53:52 -0700
Message-ID: <87bp6pviwf.fsf@deeprootsystems.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-4-git-send-email-ohad@wizery.com>
	<87r5fmxghm.fsf@deeprootsystems.com>
	<AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49543 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0JSXyF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 19:54:05 -0400
In-Reply-To: <AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com>
	(Ohad Ben-Cohen's message of "Tue, 19 Oct 2010 23:02:37 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Simon Que <sque@ti.com>

Ohad Ben-Cohen <ohad@wizery.com> writes:

> On Tue, Oct 19, 2010 at 7:03 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>>> +postcore_initcall(hwspinlocks_init);
>>
>> Any reason this needs to be a postcore_initcall? =C2=A0Are there use=
rs of
>> hwspinlocks this early in boot?
>
> i2c-omap, which is subsys_initcall (the I2C bus is shared between the
> A9 and the M3 on some OMAP4 boards).

Rather than moving towards having more drivers have to be built in (and
depend on their probe order) we need to be moving towards building all
these drivers as modules, including omap-i2c.

> And to allow early board code to reserve specific hwspinlock numbers
> for predefined use-cases, we probably want to be before arch_initcall=
=2E

There's no reason for board code to have to do this at initcall time.

This kind of thing needs to be done by platform_data function pointers,
as is done for every other driver that needs platform-specific driver
customization.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
