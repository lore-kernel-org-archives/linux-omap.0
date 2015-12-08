From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
Date: Tue, 8 Dec 2015 07:51:22 -0800
Message-ID: <20151208155122.GV23396@atomide.com>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
 <4387766.cHF7OBX0cm@wuerfel>
 <5666AF51.9080306@ti.com>
 <2433527.Up3lk3Mgej@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2433527.Up3lk3Mgej@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> [151208 02:26]:
> On Tuesday 08 December 2015 12:22:09 Peter Ujfalusi wrote:
> > On 12/08/2015 11:51 AM, Arnd Bergmann wrote:
> > > On Tuesday 08 December 2015 09:42:26 Peter Ujfalusi wrote:
> > >> On 12/04/2015 11:51 PM, Tony Lindgren wrote:
> > >>>>
> > >>>> Please just drop the /bits/ 16 and use normal cells.
> > >>>
> > >>> Yeah agreed, makes things less confusing for sure 
> > >>
> > >> 4.4 will be the first kernel where we will have the new eDMA bindings. I have
> > >> chosen to use 16bit array for specifying the channels used for memcpy
> > >> (ti,edma-memcpy-channels) and for the reserving paRAM slots
> > >> (ti,edma-reserved-slot-ranges). As of now we have maximum of 64 channels and
> > >> 512 paRAM slots. 16bit is more than enough to store this information and it
> > >> even gives us enough room if ever in the future these numbers are going to
> > >> increase (which  they are not).
> > >>
> > >> But in order to change them to 32bit the driver needs to be changed as well.
> > >> Currently we do not have drivers (in 4.4) using the new bindings, 4.4 is not
> > >> yet out, so it might be possible to change the binding document and the driver
> > >> to use 32bit arrays. The driver internally uses 16bit type for these which I'm
> > >> not going to change, but the code parsing the DT needs to be adjusted for the
> > >> new data type.
> > >>
> > >> If Vinod is willing to take update for the DT binding of eDMA for 4.4-rc, I
> > >> can cook up the patch(es) to do so.
> > > 
> > > I hadn't realized that it was already in 4.4-rc. The change should be trivial
> > > enough though, so I'd still do it. If Vinod would rather not change it now,
> > > it's not overly important though.
> > 
> > But this change must be done before we have actual users of these properties,
> > which is the am33xx, am437x and the da850 conversion series I have sent recently.
> > We might want to have this changed for 4.4 since it is going to be an LTS
> > release...
> 
> Yes, that's what I meant: We either get the patch into 4.4 by creating a
> branch for Vinod to pull with this change, and base all other changes in your
> 4.5 series on the same branch, or we don't change it at all.

Sounds good to me. If there's an immutable branch against v4.4-rc1 with just
that change in it will make our lives easier.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
