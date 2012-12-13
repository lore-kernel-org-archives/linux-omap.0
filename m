From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 01/10] ARM: OMAP3/4: cpuidle: fix sparse and checkpatch
 warnings
Date: Thu, 13 Dec 2012 05:55:33 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EBAF47B@DBDE01.ent.ti.com>
References: <20121209011755.19716.25244.stgit@dusk.lan>
 <20121209012334.19716.44831.stgit@dusk.lan> <50C840C9.5000407@ti.com>
 <alpine.DEB.2.00.1212130541320.25415@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37309 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab2LMFzn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Dec 2012 00:55:43 -0500
In-Reply-To: <alpine.DEB.2.00.1212130541320.25415@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 13, 2012 at 11:11:49, Paul Walmsley wrote:
> On Wed, 12 Dec 2012, Vaibhav Hiremath wrote:
> 
> > I am using your "paul-linux-pwrdm_post_fpwrst_devel_a_3.9" branch, where
> > all the patches which you have posted are present (I believe so) and I
> > am getting following sparse warning -
> 
> The branch name to use is:
> 
> "TEST_pwrdm_post_fpwrst_devel_a_3.9"
> 

If I am correct, it only includes one additional patch (merge commit), 
right???

commit d94831e0005fee743cefd28f4c20b7c435c71236
Merge: 3e885c6 80ab3b2
Author: Paul Walmsley <paul@pwsan.com>
Date:   Sun Dec 9 13:06:51 2012 -0700

    build fixes



Does this also fix sparse warnings? 

Thanks,
Vaibhav

> 
> - Paul
> 

