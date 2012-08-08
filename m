From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 1/1] ARM: OMAP2+: hwmod: Print an error message if no
 match exists for a hwmod class
Date: Wed, 8 Aug 2012 16:34:15 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB32ABA@DBDE01.ent.ti.com>
References: <1344422117-20707-1-git-send-email-vaibhav.bedia@ti.com>
 <alpine.DEB.2.00.1208080803560.5447@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54241 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758805Ab2HHQeX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 12:34:23 -0400
In-Reply-To: <alpine.DEB.2.00.1208080803560.5447@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "paul@pswan.com" <paul@pswan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On Wed, Aug 08, 2012 at 19:35:50, Paul Walmsley wrote:
[...]
> It doesn't seem to me that this would necessarily always be an error.  
> Suppose some init code to create cpsw devices is running on an OMAP3430.  
> Then a omap_hwmod_for_each_by_class() that doesn't locate anything 
> wouldn't be an error, right?
> 

Well, I think a failed lookup operation will be a bit expensive since it
iterates over the whole list of registered hwmods and hence put in the
pr_err(). But I don't see how the SoC specific example that you pointed out
could be handled without putting in cpu_is_* checks in the registration
process itself :(

Would a pr_debug() be ok?

Regards,
Vaibhav B.

