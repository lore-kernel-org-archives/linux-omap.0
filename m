From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH for 4.4 0/2] DT/dmaengine: edma: Convert 16bit arrays to
 32bit
Date: Wed, 9 Dec 2015 12:12:27 -0800
Message-ID: <20151209201226.GB23396@atomide.com>
References: <1449649091-9848-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449649091-9848-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [151209 00:19]:
> Hi,
> 
> Based on the discussion regarding to (convert am33xx to use the new eDMA
> bindings):
> https://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg122117.html
> 
> This two patch will convert the new eDMA binding to not use 16bit arrays for
> memcpy channel selection and for marking slots reserved.
> The '/bits/ 16' seams to be causing confusion so it is probably better to just
> use standard type for the arrays.
> 
> The new bindings for the eDMA is introduced for 4.4 and we do not have users of
> it, which means that we can still change it w/o the risk of breaking anything
> and we do not need to maintain the compatibility with 16bit arrays.
> 
> The changes in the eDMA driver is local to the DT parsing and should not
> conflict with other changes (like the filter function mapping support). Hrm,
> there might be trivial conflict in the include/linux/platform_data/edma.h with
> the "dmaengine 'universal' API".
> 
> Tony, Arnd, Vinod: Can you agree on the practicalities on how these patches are
> going to be handled? I would like to send the updated am33xx/am437x conversion
> for 4.5 based on these changes.

Yes this should go into v4.4 as discussed, otherwise it will be a mess.
For both, please feel free to add:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

I suggest Vinod sets up an immutable branch against v4.4-rc1 with just these
two patches. Then it can get merged into whichever branch needs it, I
certainly will need it as most of my v4.5 branches are v4.4-rc1 or -rc2
based.

Then the immutable branch can be merged into v4.4 by Vinod or Arnd.

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
