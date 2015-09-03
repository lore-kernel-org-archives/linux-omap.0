From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/4] omap: Fix broken address translation for pbias
Date: Thu, 3 Sep 2015 08:10:06 -0700
Message-ID: <20150903151005.GU4215@atomide.com>
References: <1441279673-28105-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441279673-28105-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: t-kristo-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [150903 04:31]:
> pbias device stopped having memory resource after
> "ARM: dts: <platform>: add minimal l4 bus layout with control module
> support" got merged. This results in platform_get_resource returning
> -EINVAL in pbias driver. This is because address translation fails
> while trying to convert the address to resource which happens
> during the device creation process during boot up.
> 
> Even though after [1], reg property in pbias dt node is un-used,
> it might be an issue if we plan to use it at a later point of time.
> 
> Patch series is created on top of [1].
> 
> [1] -> https://lkml.org/lkml/2015/9/3/51
> 
> Verified the address in omap4 panda, omap5 uevm and dra72 boards.

Your other series is obviously needed for v4.3.. But seems these
are also needed for stable? If so, which versions, v4.2+?

Can you please just do a single patch with multiple Fixes tags
as they fix regression for multiple commits? Doing tons of one
liner patches for the same thing just creates commit log noise..

Remember to not Cc stable when posting, I'll add that tag when
committing if needed.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
