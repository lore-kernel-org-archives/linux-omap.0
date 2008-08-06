From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH RFC] MUSB: Fix index register corruption seen with
 g_ether and Windows host
Date: Wed, 6 Aug 2008 13:39:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8CBE@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8A84@dbde02.ent.ti.com>
	 <386072610808052126o85e13cdm45925abdde96f159@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02569B8B2F@dbde02.ent.ti.com>
 <386072610808052311v59f177afp2a1c58fb8a7b0d7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:46398 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730AbYHFIUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 04:20:43 -0400
In-Reply-To: <386072610808052311v59f177afp2a1c58fb8a7b0d7d@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

> >> Actually, I'm still struggling in a bug similar with this one on Blackfin.
> >> We ran following testcase 100 times, 10-20 times tastcases failed.
> >>
> >> ---
> >> $ ./testusb -D /proc/bus/usb/005/012 -t14 -c 15000 -s 256 -v 1
> >> unknown speed   /proc/bus/usb/005/012
> >> /proc/bus/usb/005/012 test 14 --> 75 (Value too large for defined data type)
> >> ---
> >>
> >> I reported this bug to our hardware designer and the omap list. Felipe
> >> said he did met this issue.
> >> From the capture data of USB analyzer, the peripheral musb sent out
> >> garbage data in the IN-STATUS stage.
> >> In that stage, the DATA length should be zero. But the peripheral sent
> >> out 1 byte or 2 bytes sometimes.
> >>
> >> Thanks
> >> -Bryan
> >
> > Hi Bryan,
> >
> > Could you tell me if you're using Indexed Mode or Flat mode?
> >
> > I'll try this out on my boards and see what I get.
> >
>
> I tried both mode, the result is same as mentioned. Typically, we use
> Flat mode on Blackfin.

Tried this with current linux-omap kernel. Works fine on the OMAP3430.
Guess that doesn't help much.

- Anand
