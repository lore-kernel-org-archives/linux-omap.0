From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 17/21] OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos
Date: Tue, 08 Nov 2011 11:20:57 -0800
Message-ID: <87r51i1kva.fsf@ti.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
	<1318952110-10659-3-git-send-email-govindraj.raja@ti.com>
	<87vcqz33y8.fsf@ti.com> <4EB8F368.5070603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4EB8F368.5070603@ti.com> (Rajendra Nayak's message of "Tue, 08
	Nov 2011 14:46:24 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> Hi Kevin,
>
> On Saturday 05 November 2011 04:12 AM, Kevin Hilman wrote:
>> However, as mentioned previously[1], due to a HW sleepdep between MPU
>> and CORE, this constraint isn't actually needed for CORE UARTs, so it's
>> a bit wasteful to go through all the constraint setting for no reason.
>
> I had a short chat with Govind on this and was trying to understand
> this better.
> Are you referring to the 'autodeps' for omap3 here, because they would
> prevent any clock domain from idling as long as MPU or IVA are active,

No, I was thinking of HW sleepdeps.  However, I looked back at the
OMAP3430 TRM and see that MPU does not have a HW sleepdep on CORE like I
thought.

> but not the other way round. Which means MPU can still idle, while CORE
> does not.
>
> My guess was, its probably the CORE domain idling itself thats causing
> the UART sluggishness, (and not MPU idling), due to higher latency,
> which is prevented with an active UART module in CORE, but not in PER.

OK, that indeed makes sense.  Thanks for correcting me.

> So Govind did a small experiment to prevent just CORE idling and let MPU
> idle alone and that did not show any sluggishness.

OK, good.

> Now, putting a pm-qos constraint for a UART in CORE still looks
> redundant because the latency requirement that UART has is in
> some way *indirectly* met (because the active UART in CORE prevents
> CORE transitions in idle).
> But don't you think the UART driver should express its
> latency constraints regardless, without thinking of any indirect ways
> in which the same requirements would have already been met?

Yes, you're right.  The driver should not need to know which powerdomain
a given UART is in.  It's probably best (and most portable) to have UART
always express its requirements all the time.

Thanks for digging into this,

Kevin
