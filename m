From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Fri, 30 Sep 2016 10:43:34 -0700
Message-ID: <20160930174334.qwngutrbvnfvsf6k@atomide.com>
References: <20160912153947.k4gnggur6usyujii@atomide.com>
 <20160920183701.nxme7yxgc6jpmgio@atomide.com>
 <20160928184234.zoleas3mvpxso36r@atomide.com>
 <3141427.tsfBWKPfxW@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3141427.tsfBWKPfxW@avalon>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [160929 02:38]:
> Hi Tony,
> 
> On Wednesday 28 Sep 2016 11:42:35 Tony Lindgren wrote:
> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160920 11:37]:
> > > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160920 10:11]:
> > >> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [160919 23:36]:
> > >>> No, I perform the following steps:
> > >>> 
> > >>> - Connect the panda board to the USB through USB (which powers the
> > >>> board on) - Let the board boot over NFS
> > >>> - Log in as root, run 'reboot'
> > >>> 
> > >>> The second boot produces the warning.
> > >> 
> > >> Oh I was looking at the errors while shutting down things.. OK yeah I
> > >> get that too along with a bunch of DSS related warnings with your
> > >> .config. Probably I did not notice it earlier because of the DSS
> > >> warnings. Will take a look.
> > > 
> > > The patch below fixes the issue for me, care to give it a try?
> > > 
> > > If that works for you I'll repost with a proper patch description.
> > 
> > Laurent, any news on when you may be able to test this one?
> 
> I just did and your patch fixes the problem for me, thanks.
> 
> Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

OK thanks for testing, will send out the two pending fixes today.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
