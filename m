From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Thu, 9 Apr 2015 16:30:33 +0100
Message-ID: <20150409153033.GR4027@n2100.arm.linux.org.uk>
References: <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk>
 <20150409134843.GQ4027@n2100.arm.linux.org.uk>
 <20150409150918.GP18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:46358 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbbDIPan (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2015 11:30:43 -0400
Content-Disposition: inline
In-Reply-To: <20150409150918.GP18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 09, 2015 at 08:09:19AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150409 06:49]:
> > On Thu, Apr 09, 2015 at 12:06:58AM +0100, Russell King - ARM Linux wrote:
> > > On Tue, Apr 07, 2015 at 08:22:08AM -0700, Tony Lindgren wrote:
> > > > Works for me. The above needs the following fix folded in to build:
> > > > 
> > > > --- a/arch/arm/mm/proc-v7.S
> > > > +++ b/arch/arm/mm/proc-v7.S
> > > > @@ -532,7 +532,7 @@ __v7_ca9mp_proc_info:
> > > >  __v7_ca8_proc_info:
> > > >  	.long	0x410fc080
> > > >  	.long	0xff0ffff0
> > > > -	__v7_proc __v7_ca8mp_proc_info, proc_fns = ca8_processor_functions
> > > > +	__v7_proc __v7_ca8_proc_info, __v7_setup, proc_fns = ca8_processor_functions
> > > >  	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
> > > >  
> > > >  #endif	/* CONFIG_ARM_LPAE */
> > > 
> > > Thanks, merged into the original patch.
> > 
> > Do you want to give me an ack for this, thanks?
> 
> The patch below works for me:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>
> 
> I'm wondering if this and the follow-up patch should be tagged
> cc: stable?
> 
> They together fix apps segfaulting both with and without 430973
> for some common use cases for distro kernels.

If we do, I'll want to merge both patches together...  For the time being,
I'll queue it without the stable tag.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
