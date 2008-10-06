From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: Current git head oops'es at boot on Overo
Date: Mon, 6 Oct 2008 14:15:37 -0700
Message-ID: <e5e6ade50810061415k60d77010x8f46be8835b6830d@mail.gmail.com>
References: <5e088bd90810061126g75ff7768k8fa768751a31e379@mail.gmail.com>
	 <200810061253.13997.david-b@pacbell.net>
	 <5e088bd90810061404r76001744w4bc094cbd98077f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:15728 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbYJFVPj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 17:15:39 -0400
Received: by qw-out-2122.google.com with SMTP id 3so650545qwe.37
        for <linux-omap@vger.kernel.org>; Mon, 06 Oct 2008 14:15:37 -0700 (PDT)
In-Reply-To: <5e088bd90810061404r76001744w4bc094cbd98077f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

I'm set up as host, using a BeagleBoard, and with the current
linux-omap git I can get USB working by unplugging and replugging the
A side of the cable (at the mini-AB connector on the BeagleBoard).

Just disconnecting the cable at the B side is not enough.  It must
have something to do with the ID pin.  So, if you have a soldered ID
pin it wouldn't work either.

Also, my cable is going into a powered 4 port high speed hub.  That
might make a difference.

- Nathan

On Mon, Oct 6, 2008 at 2:04 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Mon, Oct 6, 2008 at 12:53 PM, David Brownell <david-b@pacbell.net> wrote:
>> On Monday 06 October 2008, Steve Sakoman wrote:
>
>>>  However unlike others, I find that musb is not functional -- and the
>>> trick of disconnecting the USB cable and then reconnecting it does not
>>> work.
>>
>> I observed the same thing.  More specifically, no IRQs arrive at
>> the twl4030-usb driver.
>>
>> The *very same kernel* works fine on Beagle... is there something
>> different about the USB setup that might explain this?
>
> I took a look at the schematics for that section of both boards and as
> far as I can tell the two boards are identical in their omap/twl4030
> interconnect for the musb section.  The linux board files are
> extremely similar too -- nothing significant as far as I can tell.
>
> I tried the same experiment and used my Overo kernel on Beagle.  I got
> exactly the same behavior on Beagle as I did on Overo.  So my results
> are different than yours.
>
> How does your kernel config set up musb -- host or OTG?  Mine is set up as host.
>
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
