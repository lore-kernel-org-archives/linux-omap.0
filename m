From: Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v3 00/11] USB: OTG/DRD Core functionality
Date: Mon, 13 Jul 2015 21:04:48 +0800
Message-ID: <20150713130446.GA20931@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <20150710075854.GA14729@shlinux2> <55A391C5.4010701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55A391C5.4010701-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 13, 2015 at 01:24:05PM +0300, Roger Quadros wrote:
> Hi,
> 
> On 10/07/15 10:58, Li Jun wrote:
> > On Wed, Jul 08, 2015 at 01:19:26PM +0300, Roger Quadros wrote:
> >> Hi,
> >>
> >> This series centralizes OTG/Dual-role functionality in the kernel.
> >> As of now I've got Dual-role functionality working pretty reliably on
> >> dra7-evm and am437x-gp-evm. xhci side of things for OTG/DRD use are already
> >> in v4.2
> > 
> > Do you have any plan to implement OTG(HNP) on some of your platforms based on
> > this OTG core?
> 
> Not yet but Joao Pinto was interested to implement full OTG for dwc3
> controllers.
> 
> Would you be interested to try out one of your platforms so that we can
> address any issues early?
> 
> cheers,
> -roger
> 

Yes, I am considering to try out OTG on chipidea driver for FSL i.mx6x platform
, which will based on your OTG core and my previous gadget update patchset.

I will comment your patchset if find any issues. Since there is still much work
to do to complete OTG HNP/SRP, so I assume this will not be done in a short time.

Li Jun
> > 
> > Li Jun
> >>
> >> http://thread.gmane.org/gmane.linux.kernel/1923161
> >>
> >> DWC3 controller and platform related patches are sent separately.
> >>
> >> Changelog:
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
