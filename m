From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH][RFC] OMAP3: PM: Adding OSWR support
Date: Mon, 31 Aug 2009 15:48:29 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9A455D7@dbde02.ent.ti.com>
References: <1251391962-11217-1-git-send-email-thara@ti.com>
 <20090828160636.GK25828@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59010 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbZHaKSk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 06:18:40 -0400
In-Reply-To: <20090828160636.GK25828@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

OSWR stands for Open Switch With Retention. 
This is one of the target power states where logic is lost for all the modules in the power domain except for the ones with Built in retention Flip Flops. This is the main difference between OFF and OSWR mode. Because of this feature, wake up latency for OSWR is lesser than OFF mode but more than CSWR (Closed Switch With Retention - where module logic retained).

Vishwa

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
Sent: Friday, August 28, 2009 9:37 PM
To: Gopinath, Thara
Cc: linux-omap@vger.kernel.org
Subject: Re: [PATCH][RFC] OMAP3: PM: Adding OSWR support

* Thara Gopinath <thara@ti.com> [090827 09:54]:
> This patch adds OSWR support for MPU/CORE domains in CPUidle.
> Two new C states are being added to the existing C states
> which makes the new states look like below.

Please explain what OSWR means, the patch description should be clear
to everybody. I guess you mean Open SWitch Retention?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

