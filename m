From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] Revert "ARM: dts: am335x-boneblack: disable RTC-only
 sleep"
Date: Mon, 6 Jul 2015 05:16:10 -0700
Message-ID: <20150706121609.GD10705@atomide.com>
References: <20150601200137.GC30984@atomide.com>
 <1434032318-3557-1-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434032318-3557-1-git-send-email-johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [150611 07:20]:
> This reverts commit 3d76be5b933e2a66d85a2f7444e68e99e8a48ad4.
> 
> The latest revision of Beaglebone Black does not support RTC-only mode.
> 
> To avoid potential hardware damage, RTC-only mode was disabled by
> default by commit 7a6cb0abe1aa ("ARM: dts: am335x-boneblack: disable
> RTC-only sleep to avoid hardware damage").
> 
> Unfortunately, an incorrect fix had already been applied, which instead
> of just disabling RTC-only mode, prevents the Beaglebone from powering
> down at all.
> 
> Revert this patch to fix the power-off regression.
> 
> Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> 
> The offending patch was incorrectly applied after Matthijs initial fix
> was posted and before the final fix (which only added some comments) was
> applied.
> 
> Note that the final version of the fix 7a6cb0abe1aa ("ARM: dts:
> am335x-boneblack: disable RTC-only sleep to avoid hardware damage")
> indicates that it should be backported to 3.12 even though RTC-only mode
> was first enabled in 3.19.

Applying this now into omap-for-v4.2/fixes.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
