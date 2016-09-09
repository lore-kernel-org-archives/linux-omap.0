From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [08/15] usb: musb: Improve PM runtime and phy handling for 2430 glue layer
Date: Fri, 09 Sep 2016 21:33:35 +0300
Message-ID: <3780063.Jn4ozlZU9e@avalon>
References: <1463014396-4095-9-git-send-email-tony@atomide.com> <1473471770.EbnIMnoyD8@avalon> <20160909172447.kw3jb3odlpwt6egv@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160909172447.kw3jb3odlpwt6egv-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Friday 09 Sep 2016 10:24:47 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [160909 10:08]:
> > On Wednesday 11 May 2016 17:53:09 Tony Lindgren wrote:
> > > This simplifies things and allows idling both MUSB and PHY
> > > when nothing is configured. Let's just return early from PM
> > > runtime if musb is not yet initialized.
> > > 
> > > Let's also warn if PHY is not configured.
> > 
> > git bisect pointed out to this patch today when I tried to find out what
> > broke nfsroot over USB ethernet gadget on my Panda board :-/ Could you
> > help me debugging and fixing that ?
> 
> OK, do you have commit 2c5575401e34 ("usb: musb: Fix locking errors for
> host only mode")? That's now in v4.8-rc5. Or which kernel are we talking
> about here?

I've originally ran into the issue on v4.8-rc2. I've then bisected the issue 
to this commit, and confirmed that both v4.7 and v4.8-rc5 are broken.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
