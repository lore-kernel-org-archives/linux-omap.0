From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [08/15] usb: musb: Improve PM runtime and phy handling for 2430
 glue layer
Date: Fri, 9 Sep 2016 10:24:47 -0700
Message-ID: <20160909172447.kw3jb3odlpwt6egv@atomide.com>
References: <1463014396-4095-9-git-send-email-tony@atomide.com>
 <1473471770.EbnIMnoyD8@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473471770.EbnIMnoyD8@avalon>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [160909 10:08]:
> Hi Tony,
> 
> On Wednesday 11 May 2016 17:53:09 Tony Lindgren wrote:
> > This simplifies things and allows idling both MUSB and PHY
> > when nothing is configured. Let's just return early from PM
> > runtime if musb is not yet initialized.
> > 
> > Let's also warn if PHY is not configured.
> 
> git bisect pointed out to this patch today when I tried to find out what broke 
> nfsroot over USB ethernet gadget on my Panda board :-/ Could you help me 
> debugging and fixing that ?

OK, do you have commit 2c5575401e34 ("usb: musb: Fix locking errors for
host only mode")? That's now in v4.8-rc5. Or which kernel are we talking
about here?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
