From: simon@santesteban.eu
Subject: RE: USB video capture shuts up
Date: Mon, 17 May 2010 09:39:24 +0200 (CEST)
Message-ID: <59962.80.35.16.215.1274081964.squirrel@mail.santesteban.eu>
References: <36070.80.35.16.215.1273843502.squirrel@mail.santesteban.eu>
    <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D898@dbde02.ent.ti.com>
    <52653.79.153.141.221.1273845314.squirrel@mail.santesteban.eu>
    <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D8A8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slcd079.piensasolutions.com ([217.76.150.162]:33202 "EHLO
	slcd079.piensasolutions.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753773Ab0EQHj0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 May 2010 03:39:26 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D8A8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "simon@santesteban.eu" <simon@santesteban.eu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> simon@santesteban.eu wrote:
>> > simon@santesteban.eu wrote:
>> >> Hi I am using a v4l2 usb video capturer (em28xx based), and it is
>> working
>> >> fine for around 5 minutes. However, it stops capturing after this
>> time.
>> >>
>> >> There is no error message sent to kmsg ot the application, which
>> >> apparently waits for more data to be received.
>> >>
>> >> The debug dump from usbmon is:
>> >>
>> > <snip usbmon dump>
>> >
>> >>
>> >> I am using kernel 2.6.34-rc7, and now the E messages are shown. In
>> kernels
>> >> 2.6.33 and 2.6.32 the bus went on sending callbacks with 0s.
>> >> I assume that there is still some work in progress on the ehci
>> module, and
>> >> eventually this issue will be solved.
>> >>
>> >> Also, when I stop the application the following message is shown:
>> >>
>> >> em28xx #0: cannot change alternate number to 0 (error=-110)
>> >>
>> >
>> > Which processor and which board are you running this on? What is the
>> > transceiver you are using? (We had issues due to inadequate
>> capacitance
>> > on some power rails, and poor board design). This could be one source
>> > of your problem.
>> >
>> > Then again, you might be hitting an OMAP errata.
>> >
>> > Are you able to use the device after you load the EHCI module again?
>> >
>>
>> I am using gumstix overo air board.
>>
>> I am using a hub attached to the overo, and the capturer
>> attached to the device.
>>
>> Once I reload the ehci-hcd module, I have to replug either the usb hub
>> or
>> the capturer so that it is detected again by ehci.
>> I mean, when I reload the ehci-hcd module the root hub is detected, but
>> not the devices attached to it.
>>
>
> What happens if you have the video capture device and another USB device
> (a flash drive maybe) connected to the external hub? Does the other
> device
> also stop working when the video capture device fails?
>
> - Anand
>

The USB flash drive connected to the hub stops working once the capturer
failed. I also get this error several times, until it gives up:

hub 1-2:1.0: Cannot enable port 2.  Maybe the USB cable is bad?
hub 1-2:1.0: cannot disable port 2 (err = -110)
hub 1-2:1.0: cannot reset port 2 (err = -110)
...
hub 1-2:1.0: hub_port_status failed (err = -110)


