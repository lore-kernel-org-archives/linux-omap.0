From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/5] omap soc changes for v3.18 merge window
Date: Wed, 24 Sep 2014 08:46:23 -0700
Message-ID: <20140924154622.GC3122@atomide.com>
References: <pull-1410478051-378788>
 <5412304a.04a8440a.56eb.ffff9329SMTPIN_ADDED_BROKEN@mx.google.com>
 <20140924050740.GA30340@localhost>
 <20140924152320.GA26581@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58431 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbaIXPqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2014 11:46:45 -0400
Content-Disposition: inline
In-Reply-To: <20140924152320.GA26581@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Olof Johansson <olof@lixom.net>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140924 08:24]:
> On 22:07-20140923, Olof Johansson wrote:
> > On Thu, Sep 11, 2014 at 04:28:55PM -0700, Tony Lindgren wrote:
> > > The following changes since commit d7eb67f7fef9c046f27a975118da2324de65a90c:
> > > 
> > >   Merge branch 'pull/v3.18/powerdomain-fixes' of https://github.com/nmenon/linux-2.6-playground into omap-for-v3.18/fixes-not-urgent (2014-09-08 15:04:24 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/soc-for-v3.18
> > > 
> > > for you to fetch changes up to 377fb3f5d9a34b2913939e0620c1c585b5913bab:
> > > 
> > >   ARM: OMAP5+: Reuse OMAP4 PM code for OMAP5 and DRA7 (2014-09-09 19:13:41 -0700)
> > > 
> > > ----------------------------------------------------------------
> > > SoC related changes for omaps for v3.18 merge window:
> > > 
> > > - PM changes to make the code easier to use on newer SoCs
> > > - PM changes for newer SoCs suspend and resume and wake-up events
> > > - Minor clean-up to remove dead Kconfig options
> > > 
> > > Note that these have a dependency to the fixes-v3.18-not-urgent
> > > tag and is based on a commit in that series.
> > 
> > Merged. Note that this also has a fresh conflict with the latest fixes,
> > so please check that I resolved it correctly.
> > 
> 
> Looks fine to me.. also, Used a couple of out of tree patches for
> testing and all looks good from test perspective:
> 
> am335x-evm:  Boot PASS: http://slexy.org/raw/s21ul7EaiK
> am335x-sk:  Boot PASS: http://slexy.org/raw/s2xxG7b5t7
> am3517-evm:  Boot PASS: http://slexy.org/raw/s21we13Ebk
> am37x-evm:  Boot PASS: http://slexy.org/raw/s209iOnepY
> am43xx-epos:  Boot PASS: http://slexy.org/raw/s28GrriVvz
> am5728-evm:  Boot PASS: http://slexy.org/raw/s2wRllyrn2
> BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2JPCJPebZ
> beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s2n4Pum58s
> beaglebone-black:  Boot PASS: http://slexy.org/raw/s20yDlR4eu
> craneboard:  Boot PASS: http://slexy.org/raw/s21DECJfEs
> dra72x-evm:  Boot PASS: http://slexy.org/raw/s2WgDuVxXj
> dra7xx-evm:  Boot PASS: http://slexy.org/raw/s2wOi9Okyk
> OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s20qOiwY38
> n900:  Boot PASS: http://slexy.org/raw/s2j6hBxA2b
> omap5-evm:  Boot PASS: http://slexy.org/raw/s20Of1TCt4
> pandaboard-es:  Boot PASS: http://slexy.org/raw/s20P0IWXJX
> pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s20QWs7BP9
> sdp2430:  Boot PASS: http://slexy.org/raw/s2fXgpekEa
> sdp3430:  Boot PASS: http://slexy.org/raw/s21GW1utPn

OK thanks looks good to me also.

Regards,

Tony

