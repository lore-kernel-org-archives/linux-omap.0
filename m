From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2 00/15] Get MUSB PM runtime working again
Date: Wed, 18 May 2016 11:07:37 -0700
Message-ID: <20160518180737.GQ5995@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <20160517211541.GA30701@uda0271908>
 <20160517215403.GP5995@atomide.com>
 <20160517220502.GA24963@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160517220502.GA24963@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160517 15:06]:
> On Tue, May 17, 2016 at 02:54:04PM -0700, Tony Lindgren wrote:
> 
> > s/pm_runtime_put/pm_runtime_put_sync/ will fix it. I'm wondering why
> > it breaks though as dsps glue does not use autosuspend? It could also
> 
> I am not familiar with pm-runtime framework, but I thought dsps glue
> does use autosuspend.
> 
> > be a case where the parent and child PM runtime use counts get out
> > of sync?
> > 
> > BTW, I did give my series a quick try here on j5eco-evm and that behaved
> > for peripheral and host enumeration. It's pretty much the same setup as
> > on am335x I believe.
> 
> Does j5eco-evm have a otg port?

Yes it has a mini-AB port and usb0_id is wired.

> The case which is broken on mine is

> - boot the board;
> - modprobe g-zero;
> - plug in a usb deivce with A-cable to the otg port;
> 
> It generates drvvbus interrupt (0x100) and connect interrupt (0x10), but
> then session bit is gone and vbus has no power, so enum failed.

Is this with or without the $subject series?

> I tried to enable some dynamic-debug log, but was unable to see any
> glue. I will try to enable musb reg access log tomorrow to see if I can
> find anything.

OK, I'm looking at implementing proper PM runtime for dsps.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
