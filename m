From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 11/12] musb_hdrc: Allow suspend if host is already
 suspended
Date: Thu, 11 Oct 2007 13:21:38 -0700
Message-ID: <20071011202139.758331E8CE1@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223283749-git-send-email-tony@atomide.com>
	<11921223301447-git-send-email-tony@atomide.com>
	<11921223311131-git-send-email-tony@atomide.com>
	<11921223321890-git-send-email-tony@atomide.com>
	<11921223331118-git-send-email-tony@atomide.com>
	<11921223352146-git-send-email-tony@atomide.com>
	<11921223372253-git-send-email-tony@atomide.com>
	<11921223381405-git-send-email-tony@atomide.com>
	<11921223392718-git-send-email-tony@atomide.com>
	<31e679430710111307s57a7f415n9b3ef2cfefe60c9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <31e679430710111307s57a7f415n9b3ef2cfefe60c9e@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com, felipebalbi@users.sourceforge.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > @@ -2128,6 +2128,9 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
> >  {
> >         struct musb     *musb = hcd_to_musb(hcd);
> >
> > +       if (musb->xceiv.state == OTG_STATE_A_SUSPEND)
> > +               return 0;
> > +
>
> Should we allow this ? If it's already suspended it doesn't make sense
> suspending again.

Allow it.  The invariant is that when the call returns,
the bus has been suspended.
