From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
Date: Fri, 2 Mar 2012 06:37:58 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317E6763@DBDE01.ent.ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
 <1324803628-16790-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1202291839130.12752@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A8317E515D@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1203012330490.22980@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54337 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab2CBGiF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 01:38:05 -0500
In-Reply-To: <alpine.DEB.2.00.1203012330490.22980@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

On Fri, Mar 02, 2012 at 12:02:31, Paul Walmsley wrote:
> Hi,
> 
> On Thu, 1 Mar 2012, Hiremath, Vaibhav wrote:
> 
> > The initialization used in the patch is correct. Unfortunately, the TRM 
> > is incorrect here. I have already raised this issue with respective 
> > folks and soon it will get corrected.
> 
> thanks for looking into this.  Could you add a brief comment or comments 
> in this file to indicate that the TRM Rev C is incorrect about those?  
> That will help others who may be reviewing this code as they track down 
> bugs.
> 

Good point. I will certainly add it in the next version of patch-sets.

Paul,
Thanks for your review comments, can we also align on the approach, 
Whether to merge am33xx powerdomain with omap4 (same direction we are now)
OR
Have separate implementation (my original approach).


Thanks,
Vaibhav
> 
> thanks
> 
> 
> - Paul
> 

