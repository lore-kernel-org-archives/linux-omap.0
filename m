From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Wed, 3 Jul 2013 19:51:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307031944580.9618@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org> <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
 <51CAEB33.5010101@ti.com> <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com> <51CBBCD8.5030600@ti.com> <alpine.DEB.2.02.1306281844090.8767@utopia.booyaka.com> <alpine.DEB.2.02.1307010211580.3741@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83ECCC435@DBDE04.ent.ti.com>
 <51D2E096.5040700@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44493 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab3GCTvK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jul 2013 15:51:10 -0400
In-Reply-To: <51D2E096.5040700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Vutla, Lokesh" <lokeshvutla@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, Kevin Hilman <khilman@linaro.org>, "Rini, Tom" <trini@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 2 Jul 2013, Nishanth Menon wrote:

> On 07/01/2013 11:29 PM, Hiremath, Vaibhav wrote:
> > 
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Monday, July 01, 2013 7:46 AM
> > > To: Vutla, Lokesh
> > > Cc: Nayak, Rajendra; Hiremath, Vaibhav; Kevin Hilman; Rini, Tom; linux-
> > > omap@vger.kernel.org; Balbi, Felipe; linux-arm-
> > > kernel@lists.infradead.org
> > > Subject: Re: OMAP baseline test results for v3.10-rc6
> > > 
> > > On Fri, 28 Jun 2013, Paul Walmsley wrote:
> > > 
> > > > On Thu, 27 Jun 2013, Lokesh Vutla wrote:
> > > > 
> > > > > Here is the catch..
> > > > > Your dtb is generated in arch/arm/boot/dts/ folder(before V3.8 dtb
> > > was
> > > > > generated in arch/arm/boot).
> > > > 
> > > > Ugh... that's probably it :-(
> to prevent this from happening again, Lokesh did post a patch:
> https://patchwork.kernel.org/patch/2796921/
> 
> Will be good to ack it if we think it might prevent such scenarios in the
> future.

Thanks for the suggestion.  

Unfortunately it wouldn't have caught the problem, since, as I mentioned 
in the E-mail you quoted, I build from a fresh tree each time.  So there 
was no previous DTB.  This wasn't caught here because 'cat' was copying 
over the kernel to its standard output, even though it was returning an 
error, and I wasn't checking the 'cat' return value.  This is obviously 
being remedied here.

Also will modify the build scripts to output each command as it's being 
run.

As far as Lokesh's patch goes: it doesn't make sense to me to remove a 
file during 'make clean' that the build process doesn't create.  So while 
I understand the motivation for the patch, and don't mind if upstream 
takes it, I personally wouldn't care to ack it.


- Paul
