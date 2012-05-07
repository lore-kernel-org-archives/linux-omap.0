From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Mon, 7 May 2012 14:17:20 +0200
Message-ID: <20120507121720.GA25020@sortiz-mobl>
References: <4F901CCC.9000703@compulab.co.il>
 <Pine.LNX.4.44L0.1204191059581.2070-100000@iolanthe.rowland.org>
 <20120420115728.GF12830@arwen.pp.htv.fi>
 <4FA61941.5080603@compulab.co.il>
 <20120507080907.GB3229@sortiz-mobl>
 <4FA7B61B.3020604@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FA7B61B.3020604-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Igor,

On Mon, May 07, 2012 at 02:46:35PM +0300, Igor Grinberg wrote:
> Hi Samuel,
> 
> On 05/07/12 11:09, Samuel Ortiz wrote:
> > Hi Igor,
> > 
> > On Sun, May 06, 2012 at 09:25:05AM +0300, Igor Grinberg wrote:
> >> Sorry, for being jumpy...
> >> Samuel has not answered yet (it has been more then two weeks already)
> > Sorry about that.
> > 
> >> and I'd like this to go into 3.5.
> > Then you may need a better changelog explaining how this fixes a regression,
> > runtime crash or build failure.
> 
> Well, I did not say it is a regression. In fact it is not.
> I just finally sent a fix to eliminate a runtime warning which was there
> for a long time and can be seen on specific configurations.
> That is why, I want it into 3.5 during the merge window
Sorry, I misread that part. Getting that one for the next merge window is just
fine.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
