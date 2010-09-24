From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3] omap: beagle: add support for wl1271 on the board
 file
Date: Fri, 24 Sep 2010 12:11:39 -0700
Message-ID: <20100924191139.GI4211@atomide.com>
References: <1285236215-21136-1-git-send-email-luciano.coelho@nokia.com>
 <20100924180316.GE8077@tuxdriver.com>
 <1285354249.9779.3.camel@powerslave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1285354249.9779.3.camel@powerslave>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "ext John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> [100924 11:42]:
> On Fri, 2010-09-24 at 20:03 +0200, ext John W. Linville wrote:
> > On Thu, Sep 23, 2010 at 01:03:35PM +0300, Luciano Coelho wrote:
> > > Add board configuration for the wl1271 daughter board.  This patch is based
> > > on Ohad Ben-Cohen's patches for Zoom boards.
> > > 
> > > Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> > > Signed-off-by: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > > ---
> > > from v2 to v3: removed accidental change to wl1271.h
> > 
> > I presume that this should come through my tree as well (since it
> > contains the move of wl12xx.h)?
> 
> Yes, this is based on your tree.  But please hold on, because there were
> some comments (namely, the expansion board should be detected, not
> configured for wl1271 by default), which I still have to fix.  I'm
> waiting for the manufacturer of the expansion board to provide me with
> some more info for proper detection.
> 
> Also, I know that there are some other work being done in the beagle
> board file, so we may need to rethink how to sync this.
> 
> So, for now, let's skip this patch and I'll provide another one when
> these issues are addressed.

You could also do it based on some kernel cmdline option. Of course
detection during the runtime would be better.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
