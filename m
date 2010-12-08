From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 8/8] Input: omap4 - pm runtime
Date: Wed, 08 Dec 2010 13:11:51 -0800
Message-ID: <87r5dsezqg.fsf@deeprootsystems.com>
References: <1285825000-25622-1-git-send-email-x0066660@ti.com>
	<87aamzl4pu.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C0041390E45B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <0680EC522D0CC943BC586913CF3768C0041390E45B@dbde02.ent.ti.com>
	(Shubhrajyoti Datta's message of "Mon, 6 Dec 2010 18:30:00 +0530")
Sender: linux-input-owner@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

"Datta, Shubhrajyoti" <shubhrajyoti@ti.com> writes:

[...]

>> Subject: Re: [PATCH v6 8/8] Input: omap4 - pm runtime
>> 
>> Abraham Arce <x0066660@ti.com> writes:
>> 
>> > Enable pm runtime in driver
>> 
>> So power is enabled on probe and cut on _remove().  Did you consider
>> doing any more fine grained PM for this device?  For example, cutting
>> power after some inactivity timer and re-enabling on a
>> keypress/interrupt?

> My idea is that the clock needs to be on to get interrupts (OMAP4 the
> control is at module level and ick/fclk level control is
> difficult). So disabling will prevent interrupts.  The keypad is in
> wakeup domain which is always on. So the power impact may be minimal.
>
> What do you think.

I think the changelog needs to be updated to describe the reasons behind
the decisions made.

Kevin


