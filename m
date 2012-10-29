From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Mon, 29 Oct 2012 08:27:30 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB5043A@DBDE01.ent.ti.com>
References: <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
 <20121018184443.GD2350@netboy.at.omicron.at> <50806B1D.9040504@ti.com>
 <20121019061630.GB2983@netboy.at.omicron.at>
 <20121019160041.GB4730@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EB4B4C7@DBDE01.ent.ti.com>
 <20121026180627.GN11908@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EB500C9@DBDE01.ent.ti.com>
 <20121029075003.GA2527@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52128 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab2J2I1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 04:27:37 -0400
In-Reply-To: <20121029075003.GA2527@netboy.at.omicron.at>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "N, Mugunthan V" <mugunthanvnm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 29, 2012 at 13:20:03, Richard Cochran wrote:
> On Mon, Oct 29, 2012 at 04:58:23AM +0000, Hiremath, Vaibhav wrote:
> > 
> > Now the expectation has grown to the level where people expect everything in 
> > the Mainline kernel and not in some custom kernel release.
> 
> You are right, except for the "has grown" part. I have always expected
> the official kernel releases to be working and complete, without the
> kind of half baked stumps that the embedded vendors are pushing.
> 
> In my experience with Freescale (and now TI also), the vendor supports
> Linux on their platform by providing a heavily patched, quick and
> dirty, customized kernel that is kinda, sorta working, somehow. This
> provides a way for their customers to get started with the development
> kits right away, and as such I have no problem with it.
> 
> What I do have a problem with is the fact the vendors then drop the
> ball and don't follow through by getting their changes into
> mainline. This makes a huge problem for the vendor's customers later
> on, when the choice becomes either stay with the dead end vendor
> kernel, or try to get mainline working all by themselves.
> 

I completely understand and I can only say that, we have learned our lessons 
long time back on this and we now try to push all our code to Mainline.

Even with TI release kernel we try to stay closer to mainline, so that later
it would be easier to submit the patches to mainline.
For example, in some cases we have back-ported some of the framework changes 
to v3.2 kernel to stay closer to mainline.

 
> And so I am pleased to hear that the Ethernet ports on the am335x will
> be working in v3.8. Better late than never.
> 

Just submitted patches to the list, care to ack them.

Thanks,
Vaibhav 

