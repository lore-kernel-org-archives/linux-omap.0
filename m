From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Bug in linux omap clock framework?
Date: Wed, 10 Dec 2008 05:04:41 +0200
Message-ID: <1228878281.3405.7.camel@localhost>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
	 <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>
	 <1228726770.8668.66.camel@tubuntu>
	 <alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com>
	 <1228831086.31061.9.camel@tubuntu>
	 <alpine.DEB.2.00.0812091612240.5902@utopia.booyaka.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52864 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbYLJDF4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Dec 2008 22:05:56 -0500
In-Reply-To: <alpine.DEB.2.00.0812091612240.5902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi Paul,
On Tue, 2008-12-09 at 16:14 -0700, ext Paul Walmsley wrote:
> Hi Tomi,
> 
> On Tue, 9 Dec 2008, Tomi Valkeinen wrote:
> 
> > I don't know much about power and clock domains, but I believe I found
> > the reason and fix for this. At least this should point to the right
> > direction.
> > 
> > It looks to me that when I do clk_enable() to a clock which is inside a
> > turned off powerdomain, clk_enable() function will return before the
> > powerdomain is fully turned on. Reading PM_PWSTST_DSS shows that the
> > powerdomain is still in transition state.
> > 
> > The following change waits until the powerdomain has finished the
> > transition. At least it fixed the problem for me, and other things seem
> > to be still working =).
> 
> Nice work - this makes sense.  Tested your patch here also. 

Just a thought:
wouldn't this feature be required in basically every similar case?

And if yes, wouldn't it be better to embed it into clk_enable() so that
the driver code doesn't have to address it explicitly and can be more
easily shared across different OMAP architectures?

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
