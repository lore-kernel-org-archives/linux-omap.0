From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v6 0/6] PM QoS: implement the OMAP low level constraints
 management code
Date: Mon, 19 Dec 2011 14:02:00 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112191337420.12660@utopia.booyaka.com>
References: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42112 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab1LSVCB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 16:02:01 -0500
In-Reply-To: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <j-pihet@ti.com>

Hi Jean

I'm really sorry it's taken me so long to do detailed review of these 
patches for merging... anyway -

On Wed, 14 Dec 2011, jean.pihet@newoldbits.com wrote:

> From: Jean Pihet <j-pihet@ti.com>
> 
> . Implement the devices wake-up latency constraints using the global
>   device PM QoS notification handler which applies the constraints to the
>   underlying layer
> . Implement the low level code which controls the power domains next power
>   states, through the hwmod and pwrdm layers
> . Add cpuidle and power domains wake-up latency figures for OMAP3, cf. 
>   comments in the code and [1] for the details on where the numbers
>   are magically coming from
> . Implement the relation between the cpuidle and per-device PM QoS frameworks
>   in the OMAP3 specific idle callbacks.
>   The chosen C-state shall satisfy the following conditions:
>    . the 'valid' field is enabled,
>    . it satisfies the enable_off_mode flag,
>    . the next state for MPU and CORE power domains is not lower than the
>      state programmed by the per-device PM QoS.

I've been reviewing these closely.  It looks to me that are some issues 
that need to be resolved before all of them are mergeable.

One issue that I noticed in this series is that there are some locking 
issues in patch 1.  It looks to me that calls to 
_pwrdm_wakeuplat_update_pwrst() can race with each other, since it's 
called outside the lock?

Another issue is with the latency data, which we've discussed previously. 
Before we merge the latency data in mainline, we need to ensure that we've 
minimized the dependency of that data on other register settings, such as 
the AUTOEXTCLKMODE bits or the external high-frequency oscillator 
stabilization time.  Otherwise any board vendor that ships devices based 
on that data will need to redo it, which we'd like to avoid.  I'll comment 
more on this in replies to those data patches.

But there is a more fundamental issue that we need to deal with before we 
should merge the low-level powerdomain portion of your patches -- an issue 
that isn't directly related to your code.  We should first switch over to 
use functional powerstates throughout our PM code.  Right now, we have 
some code that tweaks powerdomain bits directly, and some code that calls 
omap_set_pwrdm_state().  We should get rid of the former, I think, so that 
there is one single code path that directly changes the low-level 
powerdomain bits.  Otherwise I think we run the risk of having one of our 
code paths lose track of what the powerdomain settings are -- and that way 
lies madness...

Anyway, I've got some experimental code to do this, but since it touches a 
lot of our existing PM code, I'd like to have Kevin's review, testing, and 
approval of it.  (And yours too, ideally ;-)  So what I'd like to do is to 
repost your series with some changes, and with the functional powerstate 
portion sorted out first.  Would you be able to help test those for 3.4?

In the meantime, it looks to me like two of your patches are good to go in 
the short term, with some tweaks - the omap_hwmod changes and the 
dev_pm_qos callback changes.  I'll repost those shortly and queue them up 
for whenever Tony wants to pull them.


- Paul
