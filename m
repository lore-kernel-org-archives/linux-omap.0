From: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
Subject: Re: [Re-send PATCH 1/1] arm: dra7xx: Add hwmod data for MDIO and CPSW
Date: Wed, 9 Jul 2014 11:55:52 +0200
Message-ID: <20140709095552.GA25154@breakpoint.cc>
References: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404825399-10330-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 2014-07-08 18:46:39 [+0530], Mugunthan V N wrote:
> Adding hwmod data for CPSW and MDIO which is present in DRA7xx SoC

I reverted my patch, applied this one and after boot I got:

|platform 48485000.mdio: Cannot lookup hwmod 'davinci_mdio'
|cpsw 48484000.ethernet: _od_fail_runtime_resume: FIXME: missing hwmod/omap_dev info
|davinci_mdio 48485000.mdio: failed to get device clock
|davinci_mdio: probe of 48485000.mdio failed with error -2
|cpsw 48484000.ethernet: Random MACID = 46:c6:34:6f:8d:c6
| (null): fck is not found

with no eth0. Is there something with my setup? I still have the device
tree pieces I posted (in case there is something wrong with them).

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
