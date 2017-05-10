From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 05/10] usb: musb: tusb6010_omap: Do not reset the
 other direction's packet size
Date: Wed, 10 May 2017 09:28:22 -0700
Message-ID: <20170510162822.GL3489@atomide.com>
References: <20170510084231.19302-1-peter.ujfalusi@ti.com>
 <20170510084231.19302-6-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170510084231.19302-6-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: b-liu-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [170510 01:45]:
> We have one register for each EP to set the maximum packet size for both
> TX and RX.
> If for example an RX programming would happen before the previous TX
> transfer finishes we would reset the TX packet side.
> 
> To fix this issue, only modify the TX or RX part of the register.

Oh this is a nice one. I think we've always had this.

Bin, care to merge this one as a fix? This should have:

Fixes: 550a7375fe72 ("USB: Add MUSB and TUSB support")
Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
