From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
Date: Fri, 2 Mar 2012 03:46:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203020337330.15424@utopia.booyaka.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com> <1324803628-16790-3-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1202291839130.12752@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A8317E515D@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1203012330490.22980@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A8317E6763@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41555 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab2CBKqs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 05:46:48 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317E6763@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

Hi

On Fri, 2 Mar 2012, Hiremath, Vaibhav wrote:

> Paul,
> Thanks for your review comments, can we also align on the approach, 
> Whether to merge am33xx powerdomain with omap4 (same direction we are now)
> OR
> Have separate implementation (my original approach).

Could you please take a look at the "am335x_prcm_devel_3.4" branch on 
git://git.pwsan.com/linux-2.6 and let me know what you think?

It is still rough, incomplete, and compile-tested only; and the patch 
commit messages have to be updated and revised; but I think it is a 
slightly better approach.

A significant change is that the prminst code changes have been removed.  
That is only needed when PRM registers are spread across multiple PRCM IP 
blocks.  This does not appear to be the case with AM33xx?  So the 
implementation has been modified to create a prm33xx.c file instead.  
This avoids an extra, unnecessary layer of indirection for PRM accesses.

This, along with the other differences between OMAP4 and this chip, means 
that a separate powerdomain33xx.c file had to be created.

The powerdomains33xx_data.c file is still missing the bitmask position 
data, but the structure members are there.

Feel free to combine, rework, or merge this series with what you are 
working on if you feel that it is a good approach.  Otherwise, let's 
discuss.


- Paul
