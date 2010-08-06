From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PM-SR][PATCH 01/12] omap3: voltage: cleanup pr_xxxx
Date: Fri, 6 Aug 2010 14:50:30 +0100
Message-ID: <20100806135030.GL398@rakim.wolfsonmicro.main>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-2-git-send-email-nm@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032401CE69@dbde02.ent.ti.com>
 <4C5BED13.6080702@gmail.com>
 <20100806121807.GD31326@sirena.org.uk>
 <4C5C09D4.50406@ti.com>
 <20100806133206.GK398@rakim.wolfsonmicro.main>
 <4C5C1030.60405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59631 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756861Ab0HFNuc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 09:50:32 -0400
Content-Disposition: inline
In-Reply-To: <4C5C1030.60405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "Gopinath, Thara" <thara@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, Aug 06, 2010 at 08:37:52AM -0500, Nishanth Menon wrote:

> >Interesting, I see better performance than that, especially hot cache,
> >and of course an educated guess as to where to look helps greatly.

> tell me about it.. ;) mebbe I can use this thread to get a machine
> upgrade budget :P.. but I guess there are a lot more folks stuck
> like me..
> just for curiosity sake, this data was on a dual core
> model name	: Intel(R) Pentium(R) 4 CPU 3.40GHz
> bogomips	: 6800.29

> with a 7200RPM SATA 500GB drive :(..

That's actually better in most respects than the laptop I tried for
comparison.
