From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators
 for v3.4
Date: Thu, 8 Mar 2012 16:32:18 -0800
Message-ID: <20120309003217.GB12083@atomide.com>
References: <877gywjhht.fsf@ti.com>
 <20120308021843.GQ12083@atomide.com>
 <87399jc6cj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33803 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab2CIAcW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 19:32:22 -0500
Content-Disposition: inline
In-Reply-To: <87399jc6cj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Kevin Hilman <khilman@ti.com> [120308 09:37]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@ti.com> [120307 11:42]:
> >> Tony,
> >> 
> >> Please pull the following support for using regulators to control the
> >> on-chip VC/VP managed voltage domains.
> >> 
> >> The regulator driver support for this is already queued in the regulator
> >> tree, and this is the supporting core work.
> >> 
> >> This combined with the CPUfreq changes to use the regulator framework
> >> will finally result in MPU DVFS working in mainline.
> >
> > Nice.. However this one might be missing some header changes?
> 
> Oh, that's because it depends on the regulator core changes that are in
> Mark's regulator tree.  You need the for-next branch of :
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 
> 
> For this to compile correctly.
> 
> Sorry, I should've been more clear above about the build dependency.

Hmm just checking.. Recently Mark replied to Peter:

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120228 02:17]:
> On Tue, Feb 28, 2012 at 09:40:10AM +0200, Peter Ujfalusi wrote:
>
> > NOTE: this series has been generated agains Takashi's topic/asoc branch merged
> > with Mark's for-next branch since this series depends on changes in Marks'
> > branch, but not yet pulled by Takashi (snd_soc_add_dai_controls implementation
> > from Liam).
>
> Never base *anything* off my for-next branch, it gets rebuilt regularly.

So can you guys please confirm that if is indeed an immutable
commit to use as a base to merge in something?

Regards,

Tony
