From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [MUSB] fix bug: when no USB device is plugged into
	theport of EZKIT-BF548, USB OTG host mode got BUG()
Date: Wed, 5 Dec 2007 15:14:18 -0800
Message-ID: <20071205231418.GG4105@atomide.com>
References: <1196417476.9628.17.camel@roc-laptop>
	<010C7BAE6783F34D9AC336EE5A01A08804ED1A22@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804ED1A22@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Gadiyar, Anand <gadiyar@ti.com> [071130 02:15]:
> Ack. We caught this too.
> 
> Next time, I think I should send the fix as soon as we catch it :)
> 
> --Anand
> 
> 
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com 
> > [mailto:linux-omap-open-source-bounces@linux.omap.com] On 
> > Behalf Of Bryan Wu
> > Sent: Friday, November 30, 2007 3:41 PM
> > To: Tony Lindgren; David Brownell; linux-omap-open-source
> > Subject: [PATCH] [MUSB] fix bug: when no USB device is 
> > plugged into theport of EZKIT-BF548, USB OTG host mode got BUG()
> > 
> > Subject: [PATCH] [MUSB] fix bug: when no USB device is 
> > plugged into the port of EZKIT-BF548, USB OTG host mode got BUG()
> > 
> > Move IRQ workqueue init before request_irq, otherwise host SUSPEND irq
> > will call schedule_work() and BUG_ON() will fire because 
> > musb_irq_work did
> > not initialised.
> > 
> > We recorded it at
> > https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?
> > action=TrackerItemEdit&tracker_id=141&tracker_item_id=3740
> > 
> > Although the Blackfin port of MUSB is not merged, this bug should be
> > common for other platform with MUSB

Pushing Today.

Tony
