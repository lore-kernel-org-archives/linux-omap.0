From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: am33xx.dtsi: Added syscon compatible prcm_dev
 device
Date: Tue, 15 Nov 2016 09:38:16 -0800
Message-ID: <20161115173816.GM4082@atomide.com>
References: <3071466.kDDk30H73u@corpeters>
 <20161115173515.GL4082@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161115173515.GL4082-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161115 09:35]:
> * Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org> [161115 01:00]:
> > This patch adds the PRM_DEV as a syscon compatible device to
> > am33xx.dtsi. This is needed for the watchdog bootstatus patch.
> 
> We somehow need to see the bootreason for sure.. But we need to
> check with Tero on the reset driver work too.
> 
> Tero, does setting up of PRM_DEVICE as syscon cause issues for
> your reset driver work?

The nightmare scenario is that we have drivers calling random
syscon areas across various interconnect targets and then we have
zero chance of getting genpd to ever to work properly.

Do the reset drivers offer some way of exporting the reset status?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
