From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] Add VTT regulators for DDR3 AMx3xx Boards
Date: Tue, 6 May 2014 09:50:55 -0700
Message-ID: <20140506165055.GM18474@atomide.com>
References: <1399319909-53795-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399319909-53795-1-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [140505 12:59]:
> The am335x-evmsk and am437x-gp-evm both have a gpio controlled regulator
> for DDR3 VTT voltage. This is configured by boot loader and previously
> just left at that but it is better to define a fixed regulator to control
> the gpio so that the kernel is aware of it.
> 
> Previous discussion here [1].
> 
> Original am437x-gp-evm patch has been updated to reflect actual voltage
> supplied by VTT regulator.

Thanks applying both into omap-for-v3.16/dt.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
