From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Fri, 13 Mar 2015 12:30:59 -0700
Message-ID: <20150313193058.GN5264@atomide.com>
References: <20150309205157.GE5140@atomide.com>
 <CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
 <20150309211306.GC22341@saruman.tx.rr.com>
 <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
 <20150309212014.GE22341@saruman.tx.rr.com>
 <20150309212622.GJ5264@atomide.com>
 <CADYTM3ZW5e5dCQbbaE02o7wxOC26+jo5Ddo+2B4Q6UCAT2pTdQ@mail.gmail.com>
 <20150309214129.GK5264@atomide.com>
 <CAALWOA-sdLzUP8_6BKvsDQeAqxCw5-n410u3=W3D5yaCLYChbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:37080 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210AbbCMTf6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Mar 2015 15:35:58 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA-sdLzUP8_6BKvsDQeAqxCw5-n410u3=W3D5yaCLYChbQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Bin Liu <binmlist@gmail.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150313 11:39]:
> Given that the documentation mentions the actual phy used, it may be
> worth mentioning this also in the driver?  i.e. that it's not a
> "dm816x phy" but a "SR70LX Synopsys USB 2.0 OTG nanoPHY" (in contrast
> to the dm814x and am335x which use a phy TI made themselves)

Hmm OK have to check that. It could also be that dm816x documentation
is copy-paste from da850 or am3517 and the PHY got changed in the
hardware as the registers don't match the documentation. Only the
dm816x errata has right documentation for the USB PHY.
 
> USB is one of the few subsystems of the DM814x I've never really
> examined in any detail, but it appears nearly identical to the AM335x.
> (e.g. the phy registers in the control module are nearly identical,
> differing only in some bits related to GPIO-mode)

OK thanks for confirming that. It's different from this one then.
 
> On 9 March 2015 at 22:41, Tony Lindgren <tony@atomide.com> wrote:
> > Note that we still are missing basic support for dm814x in mainline,
> > I'm planning to tackle that at some point but I don't know when I'm
> > going to get to it..
> 
> Do ping me if you have questions. While I still don't have time to
> really throw myself on the task myself, and I'm still hindered by
> insufficient knowledge of the kernel, I do have quite a bit of
> experience with the processor itself.
> 
> 
> BTW, w.r.t. the old "official" TI kernel for dm81xx: there are
> actually two relevant forks of the unmaintained
> arago-omap3/ti81xx-master branch, namely:
> 
> http://arago-project.org/git/projects/?p=linux-ipnc-rdk-dm81xx.git
> http://arago-project.org/git/projects/?p=linux-dvr-rdk-dm81xx.git
> 
> which contain various bugfixes, including for usb (though also patches
> specific to those SDKs).

Yeah it will be several days of work anyways, not currently my
priority for sure. Would be nice to get it done though.

Regards,

Tony
