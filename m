From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/8] musb_core: make disconnect and suspend interrupts
 work again
Date: Thu, 24 Jun 2010 10:01:20 -0700
Message-ID: <20100624170120.GB5801@kroah.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <20100624060151.GD8078@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100624060151.GD8078-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-l3A5Bk7waGM@public.gmane.org" <gregkh-l3A5Bk7waGM@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, "stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 24, 2010 at 09:01:51AM +0300, Felipe Balbi wrote:
> On Thu, Jun 17, 2010 at 12:40:34PM +0200, ext Ajay Kumar Gupta wrote:
> >From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> >
> >Commit 1c25fda4a09e8229800979986ef399401053b46e (usb: musb: handle irqs in the
> >order dictated by programming guide) forgot to get rid of the old 'STAGE0_MASK'
> >filter for calling musb_stage0_irq(), so now disconnect and suspend interrupts
> >are effectively ignored...
> >
> >Signed-off-by: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> >Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> >Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

I don't have the original versions of any of these anymore.  Can you
resend them to me with your Ack?  Or Ajay, can you?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
