From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Testing the powerdomain changes
Date: Sun, 23 Dec 2012 09:09:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212230907580.16045@utopia.booyaka.com>
References: <alpine.DEB.2.00.1212092040310.351@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56146 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab2LWJJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 04:09:41 -0500
In-Reply-To: <alpine.DEB.2.00.1212092040310.351@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: t-kristo@ti.com, jean.pihet@newoldbits.com, b-cousson@ti.com, rnayak@ti.com, khilman@deeprootsystems.com

On Sun, 9 Dec 2012, Paul Walmsley wrote:

> in case anyone is interested in trying out the recent powerdomain & PM 
> changes, posted for 3.9, there's a temporary branch 
> "TEST_pwrdm_post_fpwrst_devel_a_3.9" in the git tree 
> git://git.pwsan.com/linux-2.6.  It's based on the PRCM cleanup branches 
> for v3.7, plus some old regression workarounds needed since the base is 
> v3.7-rc2.  Once 3.8 comes out, this branch will be rebased there ASAP, 
> assuming we don't have another huge set of regressions...

TEST_pwrdm_post_fpwrst_devel_a_3.9 has been updated against v3.8-rc1.  
Looks like there might be a few bugs to track down.  I know there are a 
few comments on the list that still need some response; will try to get to 
those soon. 


- Paul
