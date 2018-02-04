From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Sun, 4 Feb 2018 09:38:40 +0100
Message-ID: <20180204093831.44322452@kemnade.info>
References: <20180204000335.29812776@kemnade.info>
        <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 4 Feb 2018 00:10:50 +0100
Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:

> Hi
> 
> On Sun, Feb 4, 2018 at 12:03 AM, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> wrote:
> > Hi,
> >
> > I booted a 4.15 kernel without udev and loaded modules piece by piece to analyze
> > pm problems. modprobe ehci-omap increases current by around 35mA and
> > also rmmod ehci-omap does not let it go down at all.
> >
> > I expect that removing hardware does the same thing
nonsense sentence from me, was to tired. I would expect that removing the modules
properly powers down the device.
> >
> > Also suspend current increases by around 15mA if that module is loaded.
> > I tested with having everything disabled which is attached to that usb bus.
> >  
> 
> Do you have an LTE connected to the usb?
> 
Yes, there is a UMTS modem attached, but it was off during the tests.
It did not enumerate on the modem.

> Michael
> 
> > System was
> > GTA04A5 (with dm3730 processor and usb3322 phy)
> >
> > I know it has worked once, but I do not remember the version.
> >
> > The kernel config used can be found here:
> > http://misc.andi.de1.cc/config-4.15.gz
> >
Regards,
Andreas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
