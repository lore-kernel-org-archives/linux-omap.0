From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 1/1] ARM: OMAP2+: hwmod: Print an error message if no
 match exists for a hwmod class
Date: Wed, 8 Aug 2012 14:19:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208081411010.6819@utopia.booyaka.com>
References: <1344422117-20707-1-git-send-email-vaibhav.bedia@ti.com> <alpine.DEB.2.00.1208080803560.5447@utopia.booyaka.com> <B5906170F1614E41A8A28DE3B8D121433EB32ABA@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38054 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab2HHUTg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 16:19:36 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EB32ABA@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "paul@pswan.com" <paul@pswan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav

On Wed, 8 Aug 2012, Bedia, Vaibhav wrote:

> On Wed, Aug 08, 2012 at 19:35:50, Paul Walmsley wrote:
>
> > It doesn't seem to me that this would necessarily always be an error.  
> > Suppose some init code to create cpsw devices is running on an OMAP3430.  
> > Then a omap_hwmod_for_each_by_class() that doesn't locate anything 
> > wouldn't be an error, right?
> 
> Well, I think a failed lookup operation will be a bit expensive since it
> iterates over the whole list of registered hwmods and hence put in the
> pr_err().

If performance is a serious problem there, we can maintain a list of hwmod 
pointers inside each struct omap_hwmod_class, updated when the hwmods are 
registered.  But as far as I know, performance hasn't been an issue here 
yet.  If performance is the real motivation, I'd rather see an 
implementation of per-class lists as described above.

> But I don't see how the SoC specific example that you pointed out
> could be handled without putting in cpu_is_* checks in the registration
> process itself :(

Hmm, why not?

To continue the earlier example, the init code in the platform code simply 
calls omap_hwmod_for_each_by_class(), and creates the appropriate device 
if anything was found.  If no cpsw IP blocks are present on a given SoC, 
nothing would happen.  No cpu_is_*() would be needed.


- Paul
