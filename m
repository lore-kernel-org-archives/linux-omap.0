From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: am33xx.dtsi: Added syscon compatible prcm_dev
 device
Date: Tue, 15 Nov 2016 21:18:29 +0200
Message-ID: <6861ab40-8727-86ab-17bc-6bb7dc3de30a@ti.com>
References: <3071466.kDDk30H73u@corpeters> <20161115173515.GL4082@atomide.com>
 <20161115173816.GM4082@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161115173816.GM4082-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 15/11/16 19:38, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161115 09:35]:
>> * Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org> [161115 01:00]:
>>> This patch adds the PRM_DEV as a syscon compatible device to
>>> am33xx.dtsi. This is needed for the watchdog bootstatus patch.
>>
>> We somehow need to see the bootreason for sure.. But we need to
>> check with Tero on the reset driver work too.
>>
>> Tero, does setting up of PRM_DEVICE as syscon cause issues for
>> your reset driver work?

Good question, currently the reset driver is on hold waiting for hwmod / 
interconnect work to nudge forward. We could probably try to even re-use 
the syscon reset driver for OMAPs (drivers/reset/reset-ti-syscon.c); 
reset handling is not performance critical as such, and we only have few 
sources for these so...

>
> The nightmare scenario is that we have drivers calling random
> syscon areas across various interconnect targets and then we have
> zero chance of getting genpd to ever to work properly.

Exporting this specific area exposes a few interesting features, like 
performing a system wide reset or tweaking SRAM PM configs (preventing 
SRAM LDOs from idling for example.)

> Do the reset drivers offer some way of exporting the reset status?

reset_control_status() can be used to read the reset status, this is 
however mostly meant for checking if reset line is currently asserted or 
not. We could in theory overload this for checking if reset has been 
asserted previously or not (checking current status for watchdog reset 
doesn't make much sense for example.)

-Tero
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
