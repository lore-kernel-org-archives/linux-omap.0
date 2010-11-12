From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [RFC 2/8] OMAP: powerdomain: Infrastructure to put arch specific
 code
Date: Fri, 12 Nov 2010 07:43:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011120741500.28692@utopia.booyaka.com>
References: <1285245291-26442-1-git-send-email-rnayak@ti.com> <1285245291-26442-2-git-send-email-rnayak@ti.com> <1285245291-26442-3-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1010120131560.16871@utopia.booyaka.com>
 <0680EC522D0CC943BC586913CF3768C003FF83459E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34832 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0KLOnT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Nov 2010 09:43:19 -0500
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003FF83459E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi Rajendra,

On Fri, 12 Nov 2010, Nayak, Rajendra wrote:

> With these 2 changes I now have the series build/booting/functional at 
> the end of each patch in the series. Was there anything else you meant 
> when you said the series had issues with patches 1, 2 and 8 applied 
> would not boot?

If you've got it building, booting, and functional at the end of every 
patch, then I guess not ;-)

> Also I wanted to post the next version of the series removing the 
> dependencies with the prm/cm accessor api fix series since that still 
> needs rework. Hope that's fine.

That's great, we can queue it up for merging in the meantime.


- Paul
