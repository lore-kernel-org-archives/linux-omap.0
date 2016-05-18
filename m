From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 00/15] Get MUSB PM runtime working again
Date: Wed, 18 May 2016 12:35:02 -0500
Message-ID: <20160518173502.GA7522@uda0271908>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <20160517211541.GA30701@uda0271908>
 <20160517215403.GP5995@atomide.com>
 <20160517220502.GA24963@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160517220502.GA24963@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, May 17, 2016 at 05:05:02PM -0500, Bin Liu wrote:
> On Tue, May 17, 2016 at 02:54:04PM -0700, Tony Lindgren wrote:
> > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160517 14:17]:
> > > Hi Tony,
> > > 
> > > On Wed, May 11, 2016 at 05:53:01PM -0700, Tony Lindgren wrote:
> > > > Hi all,
> > > > 
> > > > Here's the whole series reposted with a bunch of additional changes.
> > > > It seems to now properly work with with multiple phy cable status
> > > > events, and should work for Ivaylo on n900 too.
> > > > 
> > > > Please re-review and re-test.
> > > 
> > > While trying to test this patch set, I just found that commit 56f487c (PM
> > > / Runtime: Update last_busy in rpm_resume) breaks dsps glue (TI am335x
> > > device). Do you have an am335x board with has otg port on it to take a
> > > look at this problem? The only board I know of which has an otg port is
> > > TI am335x GP evm.
> > 
> > Hmm sure I can take a lok. Chances are that just doing a change for
> 
> Ok, thanks.
> 
> > s/pm_runtime_put/pm_runtime_put_sync/ will fix it. I'm wondering why
> > it breaks though as dsps glue does not use autosuspend? It could also
> 
> I am not familiar with pm-runtime framework, but I thought dsps glue
> does use autosuspend.

I think I found the problem. Before having the offending patch,
musb_gadget_pullup() got called by musb_gadget_start(), then pm_suspend
immediately (~2us) happens, and musb_save_context() backs up DEVCTL register
which has session bit set.

But with the offending patch, pm_suspend happends much later (~200ms)
after musb_gadget_pullup() is called, so by this time when
musb_save_context() is called, session bit is already cleared by the
controller, so the backup of DEVCTL register does not have session bit
set. Later when pm_resume, musb_restore_context() cleared the seesion
bit.

Regards,
-Bin.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
