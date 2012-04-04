From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Wed, 4 Apr 2012 12:07:17 +0100
Message-ID: <20120404110717.GE32505@mudshark.cambridge.arm.com>
References: <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
 <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
 <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
 <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
 <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
 <20120403094749.GH17741@mudshark.cambridge.arm.com>
 <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
 <20120403123444.GL17741@mudshark.cambridge.arm.com>
 <alpine.DEB.2.00.1204031800060.8000@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36876 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756037Ab2DDLHv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 07:07:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204031800060.8000@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <ming.lei@canonical.com>, "eranian@gmail.com" <eranian@gmail.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

On Wed, Apr 04, 2012 at 01:00:53AM +0100, Paul Walmsley wrote:
> On Tue, 3 Apr 2012, Will Deacon wrote:
> 
> > I'll take JTAG for a whirl to see where we are. If anything looks wrong in
> > my dmesg, please shout (there are plenty of things in there that look like
> > they've gone awry).
> 
> Might be worth booting with initcall_debug on the kernel command line.  
> That will probably be easier than dealing with JTAG.

JTAG is unusable anyway because it requires a new MLO, which makes the
problem disappear.

Using initcall_debug I tracked the hang down to cti_unlock:

	val = __raw_readl(base + LOCKSTATUS);

causes the board to die, presumably because CoreSight isn't in a fit state
to be poked.

Will
