From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
Date: Thu, 29 Mar 2012 09:14:19 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83183FC32@DBDE01.ent.ti.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com>
 <79CD15C6BA57404B839C016229A409A83183E0CE@DBDE01.ent.ti.com>
 <4F73FD52.60209@ti.com>
 <79CD15C6BA57404B839C016229A409A83183FB9F@DBDE01.ent.ti.com>
 <4F74252A.7060809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54947 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab2C2JOa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 05:14:30 -0400
In-Reply-To: <4F74252A.7060809@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 29, 2012 at 14:32:34, Nayak, Rajendra wrote:
> On Thursday 29 March 2012 02:26 PM, Hiremath, Vaibhav wrote:
> > The point I was trying to make here was, cpu_is_xxx() check will become ugly,
> > as more and more devices gets added to the list, am33xx being the first one
> > in omap34xx family.
> 
> So are there more, other than AM33xx which are cortex A8 based but
> share the OMAP4 PRCM IP block?
> 

I would say, probably yes. 

But, things are so dynamic and you never know how things will shape up by 
the time you freeze the design.

Thanks,
Vaibhav

