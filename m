From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] Fix mmc/sd card detect gpio dt definition
Date: Mon, 12 Oct 2015 16:48:31 -0700
Message-ID: <20151012234831.GT23801@atomide.com>
References: <1444640832-7396-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444640832-7396-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org> [151012 02:12]:
> The mmc/sd card detect gpio definition in DT is not defined as
> per hardware design, the card detect gpio is an active low
> signal.
> 
> As per MMC/SD device tree binding documentation, the card detect
> signal should be an active low signal and when ever a hardware is
> designed with an active high card detect gpio then "cd-inverted"
> dt parameter should be used to detect the actual status for the
> card.
> 
> This was not captured till now because gpio is used as interrupt
> source and mmc_rescan task is scheduled. The value of the gpio
> is not used to determine card presence.

OK applying into omap-for-v4.4/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
