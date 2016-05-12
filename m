From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V2] ARM: dts: am57xx-idk-common: Fix input supply names
Date: Thu, 12 May 2016 13:46:02 -0700
Message-ID: <20160512204601.GY5995@atomide.com>
References: <1462541877-20032-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462541877-20032-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160506 06:39]:
> Palmas Regulator is an exception and does not follow the standard
> "vin-supply" common definitions for all regulators, as a result of this,
> the input supplies are not reported to regulator framework, with the
> obvious result of not being appropriately mapped. Fix the same.
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
> Changes since V1:
> 	- fix up fat fingered deletion of regulator name of ldortc
> V1: https://patchwork.kernel.org/patch/9028201/

Applying into omap-for-v4.7/dt as a fix for the merge window.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
