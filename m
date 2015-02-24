From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DTS: omap3-n900.dts: fix i2c bus numbering
Date: Tue, 24 Feb 2015 10:02:17 -0800
Message-ID: <20150224180217.GB11056@atomide.com>
References: <1423410536-16579-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20150209150245.GC21362@kahuna>
 <54D8DA56.8060400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery5.ore.mailhop.org ([54.148.219.64]:34144 "EHLO
	pmta1.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752769AbbBXSGe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2015 13:06:34 -0500
Content-Disposition: inline
In-Reply-To: <54D8DA56.8060400@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, pali.rohar@gmail.com, pavel@ucw.cz, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [150209 08:07]:
> 
> 
> On  9.02.2015 17:02, Nishanth Menon wrote:
> >On 17:48-20150208, Ivaylo Dimitrov wrote:
> >>With legacy boot i2c buses on Nokia N900 are numbered i2c1, i2c2 and i2c3.
> >>Commit 20b80942ef4e ("ARM: dts: OMAP3+: Add i2c aliases") fixed the
> >>numbering with DT boot, but introduced a regression on N900 - aliases
> >>become i2c0, i2c1 and i2c2. Fix that by providing the correct aliases in
> >>the board dts.
> >>
> >>Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> >>---
> >I suppose this is due to some legacy userspace breakage?
> >if yes, we do not intend to break userspace :), So:
> 
> Yes, legacy userspace breakage :)

Applying into omap-for-v4.0/fixes thanks,

Tony
