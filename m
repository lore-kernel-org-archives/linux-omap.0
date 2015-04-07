From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Tue, 7 Apr 2015 14:58:42 +0100
Message-ID: <20150407135841.GM4027@n2100.arm.linux.org.uk>
References: <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:41181 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbbDGN6u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2015 09:58:50 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Apr 06, 2015 at 08:14:30PM +0200, Matthijs van Duin wrote:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [150406 10:15]:
> > Why custom function, if IBE bit is zero, BTB invalidate instruction is a
> > NOP. Do you think that "mcr p15, 0, r2, c7, c5, 6" executed as a NOP will
> > put so much overhead, that it deserves a custom function?
> 
> Executing them as nop is Cortex-A8 specific. On other ARMv7 CPUs, BTB
> invalidation on context switch may be unnecessary yet expensive.

That can be solved (see the patch I just posted) so I wouldn't worry
too much about that issue.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
