From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PM-SR][PATCH 01/12] omap3: voltage: cleanup pr_xxxx
Date: Fri, 6 Aug 2010 14:32:06 +0100
Message-ID: <20100806133206.GK398@rakim.wolfsonmicro.main>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-2-git-send-email-nm@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032401CE69@dbde02.ent.ti.com>
 <4C5BED13.6080702@gmail.com>
 <20100806121807.GD31326@sirena.org.uk>
 <4C5C09D4.50406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44700 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1761334Ab0HFNcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 09:32:09 -0400
Content-Disposition: inline
In-Reply-To: <4C5C09D4.50406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "Gopinath, Thara" <thara@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, Aug 06, 2010 at 08:10:44AM -0500, Nishanth Menon wrote:

> a) when the strings are split up when they go multiple lines:
> E.g.:
> 	"abcd "
> 	"efg"
> print comes out abcd efg

That's generally considered bad practice for precisely this reason.

> c) time required:
> $ time git grep "DEBUG option not enabled" .
> arch/arm/mach-omap2/smartreflex.c:              pr_notice("DEBUG
> option not enabled!\n  \
> arch/arm/mach-omap2/voltage.c:          pr_notice("DEBUG option not
> enabled!\n  \

> real	1m34.722s
> user	0m0.440s
> sys	0m1.820s

> Vs cscope or ctags where it is rather instantaneous if you know the
> function name..

Interesting, I see better performance than that, especially hot cache,
and of course an educated guess as to where to look helps greatly.
