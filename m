From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Sun, 4 Feb 2018 11:50:52 +0100
Message-ID: <20180204115052.2fe3e1db@kemnade.info>
References: <20180204000335.29812776@kemnade.info>
        <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com>
        <20180204093831.44322452@kemnade.info>
        <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, 4 Feb 2018 09:43:45 +0100
Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:

> Hi Andreas
> 
> On Sun, Feb 4, 2018 at 9:38 AM, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> wrote:
> > On Sun, 4 Feb 2018 00:10:50 +0100
> > Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
> >  
> >> Hi
> >>
> >> On Sun, Feb 4, 2018 at 12:03 AM, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> wrote:  
> >> > Hi,
> >> >
> >> > I booted a 4.15 kernel without udev and loaded modules piece by piece to analyze
> >> > pm problems. modprobe ehci-omap increases current by around 35mA and
> >> > also rmmod ehci-omap does not let it go down at all.
> >> >
> >> > I expect that removing hardware does the same thing  
> > nonsense sentence from me, was to tired. I would expect that removing the modules
> > properly powers down the device.  
> >> >
> >> > Also suspend current increases by around 15mA if that module is loaded.
> >> > I tested with having everything disabled which is attached to that usb bus.
> >> >  
> >>
> >> Do you have an LTE connected to the usb?
> >>  
> > Yes, there is a UMTS modem attached, but it was off during the tests.
> > It did not enumerate on the modem.
> >  
> 
> Just to understand if the suspend current drop was connected to the
> suspend of lte modem on your side.
> So you don't have anything connected on usb bus?
> 
Suspend current is increased when the ehci-omap module is loaded
in comparison to the state. I tested with the modem disabled, so there
is nothing on the bus. Increased suspend current is one thing,
current_before_modprobe_ehci_omap != current_after_rmmod_ehci_omap.

I am testing with init=some_testscript.sh, so no userspace
is doing strange things. No module autoload or something.

Regards,
Andreas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
