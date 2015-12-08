From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
Date: Tue, 08 Dec 2015 10:51:50 +0100
Message-ID: <4387766.cHF7OBX0cm@wuerfel>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com> <20151204215115.GP23396@atomide.com> <566689E2.7060907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <566689E2.7060907-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 08 December 2015 09:42:26 Peter Ujfalusi wrote:
> On 12/04/2015 11:51 PM, Tony Lindgren wrote:
> >>
> >> Please just drop the /bits/ 16 and use normal cells.
> > 
> > Yeah agreed, makes things less confusing for sure 
> 
> 4.4 will be the first kernel where we will have the new eDMA bindings. I have
> chosen to use 16bit array for specifying the channels used for memcpy
> (ti,edma-memcpy-channels) and for the reserving paRAM slots
> (ti,edma-reserved-slot-ranges). As of now we have maximum of 64 channels and
> 512 paRAM slots. 16bit is more than enough to store this information and it
> even gives us enough room if ever in the future these numbers are going to
> increase (which  they are not).
> 
> But in order to change them to 32bit the driver needs to be changed as well.
> Currently we do not have drivers (in 4.4) using the new bindings, 4.4 is not
> yet out, so it might be possible to change the binding document and the driver
> to use 32bit arrays. The driver internally uses 16bit type for these which I'm
> not going to change, but the code parsing the DT needs to be adjusted for the
> new data type.
> 
> If Vinod is willing to take update for the DT binding of eDMA for 4.4-rc, I
> can cook up the patch(es) to do so.

I hadn't realized that it was already in 4.4-rc. The change should be trivial
enough though, so I'd still do it. If Vinod would rather not change it now,
it's not overly important though.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
