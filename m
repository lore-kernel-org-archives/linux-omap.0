From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH 4/5] musb: use system DMA for unaligned buffers on RTL
 >= 1.8
Date: Thu, 13 May 2010 22:43:11 +0300
Message-ID: <20100513194311.GA19318@gandalf>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-3-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-4-git-send-email-ajay.gupta@ti.com>
 <4BEAAA8A.1000003@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044E405072@dbde02.ent.ti.com>
 <4BEAC268.1080601@ru.mvista.com>
 <20100512175543.GD3285@gandalf>
 <19F8576C6E063C45BE387C64729E7394044E40516A@dbde02.ent.ti.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E40516A-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org" <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 13, 2010 at 09:44:11AM +0530, Gupta, Ajay Kumar wrote:
> Hi,
> > -----Original Message-----
> > From: Felipe Balbi [mailto:me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org]
> > Sent: Wednesday, May 12, 2010 11:26 PM
> > To: Sergei Shtylyov
> > Cc: Gupta, Ajay Kumar; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> > omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: Re: [PATCH 4/5] musb: use system DMA for unaligned buffers on RTL
> > >= 1.8
> > 
> > On Wed, May 12, 2010 at 06:59:52PM +0400, Sergei Shtylyov wrote:
> > >    Better wrap your stuff into #ifdef OMAP, I think...
> > 
> > please don't, better to use the bounce buffer... It would work on
> > blackfin, davinci and omap...
> 
> Just working is not enough. We need to think of performance and cpu
> loading as well.

allocating a bounce buffer doesn't take long and you can still use
mentor DMA to transfer the data.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
