From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: status of USB on omap35xx ?
Date: Wed, 10 Dec 2008 15:02:43 -0800
Message-ID: <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
	 <1228926833.32014.162.camel@localhost.localdomain>
	 <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:12175 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbYLJXCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2008 18:02:43 -0500
Received: by wf-out-1314.google.com with SMTP id 27so401130wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 10 Dec 2008 15:02:43 -0800 (PST)
In-Reply-To: <200812101028.25235.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Dec 10, 2008 at 10:28 AM, David Brownell <david-b@pacbell.net> wrote:
> The OTG link is in usable shape, but the EHCI one isn't.
>
>
> On Wednesday 10 December 2008, Felipe Balbi wrote:
>> >
>> > What are the issues ?
>
> I have a prototype Overo and one issue there is that the
> GPIO to let the EHCI port supply VBUS power isn't hooked
> up!  I know how to modify that board, but somehow that
> keeps slipping off my radar ... :)

That issue is fixed on the shipping "Summit" boards.

> I don't know the details, but the big problem with EHCI
> on OMAP3 is evidently some kind of silicon issue that
> shows up through the transceiver hookup and prevents the
> link from being reliable.  I'm told that some boards using
> that without a transceiver -- for on-board communication,
> not for an external link -- have been successful.
>
> Folk at TI were looking at those issues; I don't know if
> they've been resolved yet, e.g. in the ES 3.0 silicon.

I see that Vikram has responded to this already.

>> It think it still has a problem during probe. If you read the driver
>> you'll see there are some infinite while loops without timeout actions.
>> And one of them is looping forever due to clock issues.
>
> That's a newish problem, but is not -- from what I've
> been told -- the Real Issue with EHCI on OMAP3.

This problem has actually been around since 2.6.27.

Prior to that, the EHCI port "sort of" worked - but not super
reliably.  It would enumerate devices on the bus, but then die
randomly afterwards.

Since somewhere during the 2.6.27 time frame we've been suffering from
the infinite loop at boot problem.

I patched around the loop that seemed to be causing the issue, but
didn't have great success getting back to even the "sort of" working
state.

I am far from being a USB expert, so the messages in the log don't
mean a whole lot to me :-)

ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OMAP-EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.28-rc7-omap1 ehci_hcd
usb usb2: SerialNumber: ehci-omap.0
<snip>
usb usb2: bus auto-suspend
usb usb2: uevent
usb 2-0:1.0: uevent
<snip>
usb usb2: usb auto-resume
usb usb2: bus auto-suspend

Steve
