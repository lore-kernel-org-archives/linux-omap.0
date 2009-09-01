From: "Girish S G" <girishsg@ti.com>
Subject: RE: [PATCH][RFC] OMAP3: PM: Adding OSWR support
Date: Tue, 1 Sep 2009 18:32:56 -0500
Message-ID: <010201ca2b5c$897481a0$507018ac@am.dhcp.ti.com>
References: <1251391962-11217-1-git-send-email-thara@ti.com> <20090828160636.GK25828@atomide.com> <FCCFB4CDC6E5564B9182F639FC35608702F9A455D7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59749 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbZIAXdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 19:33:04 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9A455D7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Sripathy, Vishwanath'" <vishwanath.bs@ti.com>, 'Tony Lindgren' <tony@atomide.com>, "'Gopinath, Thara'" <thara@ti.com>
Cc: linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> Sripathy, Vishwanath
> Subject: RE: [PATCH][RFC] OMAP3: PM: Adding OSWR support
> 
> OSWR stands for Open Switch With Retention.
> This is one of the target power states where logic is lost for all the modules in the power domain
> except for the ones with Built in retention Flip Flops. This is the main difference between OFF and

So, this's supported for CORE, PER and MPU?

-Girish



