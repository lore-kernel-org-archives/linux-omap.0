From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable requested pads
Date: Fri, 04 Mar 2011 17:57:55 -0800
Message-ID: <87tyfi49cs.fsf@ti.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com>
	<87lj0u8mrf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52070 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752121Ab1CEB57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 20:57:59 -0500
In-Reply-To: <87lj0u8mrf.fsf@ti.com> (Kevin Hilman's message of "Fri, 04 Mar
	2011 15:54:44 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Kevin Hilman <khilman@ti.com> writes:

> "Govindraj.R" <govindraj.raja@ti.com> writes:

[...]

>>  /* Assumes the calling function takes care of locking */
>>  void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>>  {
>> @@ -342,6 +365,9 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>>  				break;
>>  			flags &= ~OMAP_DEVICE_PAD_ENABLED;
>>  			val = pad->idle;
>> +			if (flags & OMAP_DEVICE_PAD_WAKEUP)
>> +				val |= OMAP_WAKEUP_EN;
>> +
>
> Is this needed on every idle transition?  
>
> You're currently setting it on every idle transition, but never clearing
> it.  If it is to be a one-time thing, then move it to the early init of
> the mux.

Just to clarify...

So as soon as the hwmod is first idled, IO-ring wakeups are enabled for
any pads that have OMAP_DEVICE_PAD_WAKEUP.

The problem here (compared with behavior of existing code) is that there 
is no provision for disabling IO-ring wakeups.

For example, with current code, you can disable wakeups from userspace
using the sysfs control file /sys/devices/.../power/wakeup, whose value
can be checked using device_may_wakeup(), like current
mach-omap2/serial.c code does.  

With this patch, IO-ring wakeups are always enabled, and never disabled.

Kevin
