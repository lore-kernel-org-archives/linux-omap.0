From: Emanoil Kotsev <deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB driver issue
Date: Wed, 30 Jul 2008 07:21:53 -0700 (PDT)
Message-ID: <317276.12528.qm@web53211.mail.re2.yahoo.com>
References: <31e679430807300505o3050a75ar2f9d8ff0cd35ea1b@mail.gmail.com>
Reply-To: deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <31e679430807300505o3050a75ar2f9d8ff0cd35ea1b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: SUBHRANIL CHOUDHURY <subhra85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Dear Felipe, I just want to tell, that while still developing kernels in the 2.6.2X series a kernel 2.6.22 can not be labeled as old. Besides it comes along with few distros as default kernel.

A lot of people like me need some kind of a stable version that we can relay on for more than playing at home, which is the case with 2.4.X tree. 

Personally, experiments with 2.6.24 brought me into a big trouble and it took many hours to migrate back to 2.6.20, so please keep in mind that if we say something like this, there is a good reason to do so.

Appreciate your understanding.


--- On Wed, 7/30/08, Felipe Balbi <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org> wrote:

> From: Felipe Balbi <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Subject: Re: USB driver issue
> To: "SUBHRANIL CHOUDHURY" <subhra85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Date: Wednesday, July 30, 2008, 2:05 PM
> Hi,
> 
> On Wed, Jul 30, 2008 at 2:59 PM, SUBHRANIL CHOUDHURY
> <subhra85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hi all,
> > I am trying to validate the USB driver on OMAP3430
> with the
> > 2.6.22.18kernel. I am facing problems in the process
> while trying to
> > do a USB
> > transfer with DMA enabled.
> > The apllication is breaking in a function called
> consistent_sync. The error
> > message is like "Unable to handle kernel Null
> pointer".
> >
> > The issue is same with both OHCI and EHCI controller.
> And the issue is not
> > coming if i disable DMA.
> >
> > Has anyone tried USB packet transfer with DMA enabled?
> Please let me know.
> 
> Why are you using such an old, support-less kernel ?
> 
> Try with current 2.6.26 out of git repository. I've
> been using musb
> driver on omap3
> for months now and it's working quite ok besides a few
> bugs hidden
> here and there
> (which I'm looking at).
> 
> ps: this list has moved to linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org and
> musb driver
> is now being
> discussed in linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org mailing list, so
> please, care
> to Cc both lists
> mentioned here.
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> --
> To unsubscribe from this list: send the line
> "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
