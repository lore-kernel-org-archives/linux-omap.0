From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
Date: Mon, 07 May 2012 16:51:14 -0700
Message-ID: <87397by2h9.fsf@ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1335462041-4949-1-git-send-email-j-keerthy@ti.com> (Keerthy's
	message of "Thu, 26 Apr 2012 23:10:31 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, j-pihet@ti.com
List-Id: linux-omap@vger.kernel.org

Rafael,

Keerthy <j-keerthy@ti.com> writes:

> From: J Keerthy <j-keerthy@ti.com>
>
> AVS(Adaptive Voltage Scaling) is a power management technique which
> controls the operating voltage of a device in order to optimize (i.e. reduce)
> its power consumption. The voltage is adapted depending on static factors
> (chip manufacturing process) and dynamic factors (temperature
> depending performance).
> The TI AVS solution is named Smartreflex. 
>
> To that end, create the AVS driver in drivers/power/avs and
> move the OMAP SmartReflex code to the new directory. The
> class driver is still retained in the mach-omap2 directory.

How should we handle this for upstream?

It does a bunch of cleanup under arch/arm then does the move to
drivers/power the end.  To avoid conflicts with other OMAP core changes,
I would suggest we take this through the OMAP tree.

With your ack, I'd be glad to take it.

Thanks,

Kevin
