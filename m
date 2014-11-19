From: Tony Lindgren <tony@atomide.com>
Subject: Re: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Wed, 19 Nov 2014 09:53:49 -0800
Message-ID: <20141119175348.GK7046@atomide.com>
References: <CAFqH_53hyYO9DHfhzDhYkTnimKR0FOQuUw4OGCM4myKoOJSQRA@mail.gmail.com>
 <20141117180413.GF7046@atomide.com>
 <CAFqH_52LV8k6OyH04dUmhzZChnHrtJR23qu1ewhU49iOVT1Mwg@mail.gmail.com>
 <20141118154204.GI7046@atomide.com>
 <CAFqH_508pYkDXO8BCR=cFGFY_CgfkhqvseUy=Z--fJMOQCo6Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44623 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756094AbaKSRyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2014 12:54:07 -0500
Content-Disposition: inline
In-Reply-To: <CAFqH_508pYkDXO8BCR=cFGFY_CgfkhqvseUy=Z--fJMOQCo6Tg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, balbi@ti.com

* Enric Balletbo Serra <eballetbo@gmail.com> [141119 03:14]:
> 2014-11-18 16:42 GMT+01:00 Tony Lindgren <tony@atomide.com>:
> 
> Checked again, and no luck. It's very weird because from the OTG point
> of view, OTG is exactly the same between Beagleboard-XM and IGEPv2.
> 
> Can you confirm that you're using kernel 3.18-rc5 without other
> patches applied ? At this moment, I don't have a Beagleboard-XM to
> test, I'll try to get one because at this moment I'm a bit stuck with
> this problem.

Yes it was with v3.18-rc5 and the defconfig patch I posted except
I had to disable all the other MUSB platforms. Also tested it with
built in modules.

Maybe you need to check the .dts pinctrl entries for hsusb0_* lines?

Regards,

Tony
