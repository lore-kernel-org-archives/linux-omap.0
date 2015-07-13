From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 00/11] USB: OTG/DRD Core functionality
Date: Mon, 13 Jul 2015 12:14:43 -0700
Message-ID: <CAL1qeaEJ9uX1vgvwO4-ABdGi5C96HZ2jBYWeKiGHJ-uqv6ooGg@mail.gmail.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436350777-28056-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Wed, Jul 8, 2015 at 3:19 AM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> Usage model:
> -----------
>
> - The OTG controller device is assumed to be the parent of
> the host and gadget controller. It must call usb_otg_register()
> before populating the host and gadget devices so that the OTG
> core is aware that it is an OTG device before the host & gadget
> register. The OTG controller must provide struct otg_fsm_ops *
> which will be called by the OTG core depending on OTG bus state.

I'm wondering if the requirement that the OTG controller be the parent
of the USB host/device-controllers makes sense.  For some context, I'm
working on adding dual-role support for Tegra210, specifically on a
system with USB Type-C.  On Tegra, the USB host-controller and USB
device-controller are two separate IP blocks (XUSB host and XUSB
device) with another, separate, IP block (XUSB padctl) for the USB PHY
and OTG support.  In the non-Type-C case, your OTG framework could
work well, though it's debatable as to whether or not the XUSB padctl
device should be a parent to the XUSB host/device-controller devices
(currently it isn't - it's just a PHY provider).  But in the Type-C
case, it's an off-chip embedded controller that determines the
dual-role status of the Type-C port, so the above requirement doesn't
make sense at all.

My idea was to have the OTG/DRD controller explicitly specify its host
and device controllers, so in DT, something like:

otg-controller {
    ...
    device-controller = <&usb_device>;
    host-controller = <&usb_host>;
    ...
};

usb_device: usb-device@.... {
    ...
};

usb_host: usb-host@... {
    ...
};

What do you think?

Thanks,
Andrew
