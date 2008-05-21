From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/2] MUSB: 2 patches to fix some bug found on Blackfin
Date: Wed, 21 May 2008 10:14:44 -0700
Message-ID: <200805211014.45170.david-b@pacbell.net>
References: <1211022081-27298-1-git-send-email-cooloney@kernel.org> <386072610805190105y6618dd9bwe32503c1ae11b865@mail.gmail.com> <20080521155003.GZ23002@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080521155003.GZ23002-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 21 May 2008, Tony Lindgren wrote:
> 
> > Great, after I enable the DMA mode 1 on Blackfin and cleanup the code,
> > I will send
> > out the code before you sent them to upstream
> 
> Maybe we should get the musb code to USB tree before that? It's been out
> of the scope for linux-omap tree for quite a while now.

I'm all for getting the musb_hdrc driver into the 2.6.27 queue...
I presume there are still some infrastructure changes in usbcore
that block that merge?  It'd be nice if we could merge musb_hdrc
without those changes (OTG related) and then update that stuff
separately.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
