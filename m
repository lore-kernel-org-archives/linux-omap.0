From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] drivers: usb: otg: make twl6030_usb as a
 comparator driver to omap_usb2
Date: Fri, 26 Oct 2012 12:01:30 -0700
Message-ID: <20121026190129.GP11908@atomide.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com>
 <1346943430-18236-3-git-send-email-kishon@ti.com>
 <CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com>
 <CAAe_U6K1RXA3b5u9WvE=2VoXym9Vj3KM7c0J27jKz+2KrV4tsg@mail.gmail.com>
 <CAH+eYFAhVE8cAte2PFk3jinV9n3m+eDLtE43QxzRXMScnFGcrA@mail.gmail.com>
 <508AA94B.10504@ti.com>
 <508AAA85.6070905@ti.com>
 <alpine.DEB.2.00.1210261750430.7573@utopia.booyaka.com>
 <508ACF0B.60808@ti.com>
 <508AD1E7.3080101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:65523 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759014Ab2JZTBi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 15:01:38 -0400
Content-Disposition: inline
In-Reply-To: <508AD1E7.3080101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Roger Quadros <rogerq@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Rabin Vincent <rabin@rab.in>, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org

* Benoit Cousson <b-cousson@ti.com> [121026 11:11]:
> On 10/26/2012 07:57 PM, Benoit Cousson wrote:
> > Hi Paul,
> > 
> > On 10/26/2012 07:54 PM, Paul Walmsley wrote:
> >> On Fri, 26 Oct 2012, Benoit Cousson wrote:
> >>
> >>> On 10/26/2012 05:16 PM, Roger Quadros wrote:
> >>>
> >>>> I still can't get musb to work on 3.7-rc2. Apparently it is still
> >>>> missing the patches from Benoit's for_3.7/dts_part2.
> >>>>
> >>>> Maybe I just need to wait for it to be merged?
> >>>
> >>> They are now in a for_3.8/dts. Unfortunately, one patch that was adding
> >>> ctrl_module address in the USB data was rejected and thus I'm not sure
> >>> it will work without that.
> >>
> >> For v3.7-rc timeframe, looks like it's waiting on an ack from you:
> >>
> >> http://www.spinics.net/lists/arm-kernel/msg201028.html
> > 
> > Oups, I missed that one. But I thought Roger was mentioning the DT patch
> > and not that one.
> > 
> > Anyway, I will answer to Tony. Thanks for the reminder Paul.
> 
> Well, in fact, I cannot even find the original email in my mailbox :-(
> I was banned again from linux-omap around that time, so that might be
> the reason.
> 
> So please take that hacky patch if it prevents the regression.

OK yes it seems like that's the only option we have until
omap4 is device tree only.

Regards,

Tony
