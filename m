From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Add support for the BeagleBoard xM A/B
Date: Fri, 18 Apr 2014 16:51:20 -0700
Message-ID: <20140418235119.GS21823@atomide.com>
References: <1397574599-29573-1-git-send-email-robertcnelson@gmail.com>
 <CAOCHtYg5_Lvi3SWuWaRTDDNhLJ32jiXsKYQmrsKaShVWpM+xWQ@mail.gmail.com>
 <534D51C1.3010007@ti.com>
 <CAOCHtYhygGFbUunY9abEkjKfpQ1hh-DfRfhm160NehSYhWJSRw@mail.gmail.com>
 <20140418225111.GP21823@atomide.com>
 <CAOCHtYjdC-OGkdaBt74xMqi5eDc1eVbU6O7VyWMEYN-U50-Abw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34783 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbaDRXv0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 19:51:26 -0400
Content-Disposition: inline
In-Reply-To: <CAOCHtYjdC-OGkdaBt74xMqi5eDc1eVbU6O7VyWMEYN-U50-Abw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <bcousson@baylibre.com>

* Robert Nelson <robertcnelson@gmail.com> [140418 16:42]:
> On Fri, Apr 18, 2014 at 5:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Robert Nelson <robertcnelson@gmail.com> [140415 08:46]:
> >>
> >> Background: i also tried getting this having this fixed in u-boot:
> >
> > Do we still need to apply this patch then?
> 
> Yeah, Tom want's it done in the kernel:
> 
> Here's my proposed u-boot patch:
> http://lists.denx.de/pipermail/u-boot/2014-January/172154.html
> 
> and Tom's recommendation:
> http://lists.denx.de/pipermail/u-boot/2014-January/172274.html
> 
> Once this hits mainline, i'll submit a patch to u-boot to check for
> the presence of this version and drop to the old dtb if not found.

OK applying into omap-for-v3.15/fixes thanks.

Tony
