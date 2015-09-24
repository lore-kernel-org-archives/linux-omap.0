From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: AM3517 usb host issue
Date: Thu, 24 Sep 2015 13:48:49 +0100
Message-ID: <5603F131.10603@codethink.co.uk>
References: <555EE311.3030507@codethink.co.uk> <20150522135039.GA5582@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150522135039.GA5582-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Linux USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 22/05/15 14:50, Felipe Balbi wrote:
> Hi,
> 
> On Fri, May 22, 2015 at 11:04:33AM +0300, Ben Dooks wrote:
>> I am trying to get the full-speed USB host working on an custom 
>> AM3517 device with the 3.18.12 kernel. The hardware works (a 
>> 2.6.37 kernel has been used for testing).
>> 
>> Does anyone have any experience of 3.18 (or similarly recent 
>> kernel on an AM3517 system) or have any pointers as where to 
>> start debugging? The ti-linux-3.14.y does not have any patches 
>> that aren't applied to the usb on 3.18.13.
>> 
>> The cpu port 1 is connected by a TI TUSB1106 usb transceiver
>> that is directly connected to a full-speed hub (TI USB2046) hub
>> so the OHCI driver is the only one in use.
>> 
>> Note, the ohci-omap3 is loaded as a module as this is how their 
>> user application expects to be able to shut down usb when it
>> does not need it.
>> 
>> The device tree configuration for the usb host:
> 
> and what exactly doesn't work ? That old OHCI driver hasn't been 
> touched in years, it's no surprise that it stopped working :-(
> 
> Anyway, what exactly doesn't work ? No device enumerates ? Do you 
> get any IRQs by plugging a new device in ?

I just found this in my backlog, and thought I should follow up with
the issue.

It turns out that even if we're not using the EHCI unit, the 120m
functional clock needs to be enabled. This may be down to an internal
routing of port signals, or the USB front-end needing it.

I've added a local boolean fix to enable the clock, and will post it
as soon as we've had a chance to review and document.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
