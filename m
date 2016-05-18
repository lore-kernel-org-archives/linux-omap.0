From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCHv2 00/15] Get MUSB PM runtime working again
Date: Wed, 18 May 2016 14:45:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1605181442440.1981-100000@iolanthe.rowland.org>
References: <20160518181403.GR5995@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160518181403.GR5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 18 May 2016, Tony Lindgren wrote:

> * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160518 10:37]:
> > I think I found the problem. Before having the offending patch,
> > musb_gadget_pullup() got called by musb_gadget_start(), then pm_suspend
> > immediately (~2us) happens, and musb_save_context() backs up DEVCTL register
> > which has session bit set.
> > 
> > But with the offending patch, pm_suspend happends much later (~200ms)
> > after musb_gadget_pullup() is called, so by this time when
> > musb_save_context() is called, session bit is already cleared by the
> > controller, so the backup of DEVCTL register does not have session bit
> > set. Later when pm_resume, musb_restore_context() cleared the seesion
> > bit.
> 
> OK sounds like that's expected as that's the current autosuspend
> timeout. See for example e6244deed843 ("i2c: omap: Fix PM regression
> with deferred probe for pm_runtime_reinit") for references why
> pm_runtime_put_sync_suspend() needs to be used if autosuspend has
> been set.
> 
> So you doing pm_runtime_put_sync_suspend() probably fixes your
> issue. (Sorry I think I mentioned just pm_runtime_put_sync()
> earlier..)

Actually it may be the other way around.  
pm_runtime_put_sync_suspend() will do an immediate suspend regardless
of the autosuspend timer, whereas pm_runtime_put_sync() will not
suspend the device until the autosuspend timer expires.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
