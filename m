From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Date: Thu, 10 Apr 2014 16:40:39 +0400
Message-ID: <53469147.50802@cogentembedded.com>
References: <Pine.LNX.4.44L0.1404091354560.28384-100000@netrider.rowland.org> <53458E95.4080505@cogentembedded.com> <534598EF.3010102@wwwdotorg.org> <53459A48.1010003@cogentembedded.com> <063D6719AE5E284EB5DD2968C1650D6D0F6F43C3@AcuExch.aculab.com> <53467720.8000400@cogentembedded.com> <534679F1.3050607@codethink.co.uk> <063D6719AE5E284EB5DD2968C1650D6D0F6F44A4@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6F44A4-VkEWCZq2GCInGFn1LkZF6NBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>, 'Ben Dooks' <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Peter.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Peter.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10-04-2014 15:14, David Laight wrote:

>>>>>       It doesn't do any pin muxing. It switches SoC internal USB
>>>>> signals between
>>>>> USB controllers. The pins remain the same.

>>>> Doesn't something like that already happen for the companion USB1
>>>> controllers for USB2 ports?

>>>      Did you mean USB 1.1 and USB 2.0 controllers by USB1 and USB2?

> Yes.

> Why do you care which USB controller is driving the pins?

    Because the controllers the driver switches between are not companions.
The multiplexing is between PCI EHCI/OHCI and Renesas USBHS (high speed device 
controller in this case) controllers on port 0 and between PCI EHCI/OHCI and 
non-PCI xHCI controller on port 2.

>>>> That also doesn't sound like you are changing the PHY.

>>>      I am changing one of the PHY registers that controls USB port
>>> (Renesas calls it channel) multiplexing.

>>>> I'd have thought that would happen if you had a single controller
>>>> that select between multiply PHY.

>>>      No, it's not the case.

> I realised that wasn't what you were doing, but at first it did seem
> to be what you were doing.

    The PHY really does belong to the USBHS controller but that multiplexing 
register inside it controls routing of the ports 0 and 2; USBHS itself is on 
port 0.

>> There is an interesting case, the USB3 shares a PHY with a SATA
>> and the PCIE and SATA also share a PHY on the R8A7790.

> Some of those look like pcb design decisions - so there is no dynamic
> changing, just config time plumbing.

    No, there are also host/device mode DIP switches on the boards which 
control port 0 signals (and the port 0 connector is micro-AB, so both a host 
and device can be connected). The second board also has OTG chip on port 0 
thru which USB ID pin can be read from the micro-AB connector.

> 	David

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
