From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
Date: Thu, 1 Mar 2012 23:32:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203012330490.22980@utopia.booyaka.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com> <1324803628-16790-3-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1202291839130.12752@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A8317E515D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59669 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015Ab2CBGcc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 01:32:32 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317E515D@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

Hi,

On Thu, 1 Mar 2012, Hiremath, Vaibhav wrote:

> The initialization used in the patch is correct. Unfortunately, the TRM 
> is incorrect here. I have already raised this issue with respective 
> folks and soon it will get corrected.

thanks for looking into this.  Could you add a brief comment or comments 
in this file to indicate that the TRM Rev C is incorrect about those?  
That will help others who may be reviewing this code as they track down 
bugs.


thanks


- Paul
