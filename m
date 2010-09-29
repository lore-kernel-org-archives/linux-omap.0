From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v8 0/6] OMAP: WDT: Implement WDT in hwmod way
Date: Wed, 29 Sep 2010 08:43:01 -0700
Message-ID: <87y6ak1rp6.fsf@deeprootsystems.com>
References: <1285252363-3630-1-git-send-email-charu@ti.com>
	<877hi5740v.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CD02B1E@dbde02.ent.ti.com>
	<87d3rw62ft.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CD02BA7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55784 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab0I2PnG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 11:43:06 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02BA7@dbde02.ent.ti.com>
	(Charulatha Varadarajan's message of "Wed, 29 Sep 2010 20:16:41
	+0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

[...]

>> 
>> Instead, I would rather have a small piece of code in omap_init_wdt()
>> which disarms the watchdog so we don't have any assumptions about
>> bootloader behavior.
>> 
>> The question remains whether this disarm should be
>> #ifndef CONFIG_OMAP_WATCHDOG or if it should happen all the time.  In
>> case the watchdog is a module, it's probe may not happen within the
>> timeout period and they system may reboot also, so I lean towards
>> disarming the watchdog unconditionally.
>
> Agreed. But this shall be handled in mach-omap2/devices.c by directly
> accessing the watchdog registers and disabling it, as the watchdog driver
> would not be available by this time. 

Correct.

> If this okay, I would send a separate patch on top my hwmod series to
> handle this.

Yes please.

Thanks,

Kevin

