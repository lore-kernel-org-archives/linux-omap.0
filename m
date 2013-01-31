From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 12/18] ARM: OMAP2+: timer: Add suspend-resume callbacks
 for clockevent device
Date: Thu, 31 Jan 2013 11:17:50 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED05777@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-13-git-send-email-vaibhav.bedia@ti.com>
 <50EC37FE.705@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433ECE0D51@DBDE01.ent.ti.com>
 <50F846D7.8060509@ti.com> <50F8DCD7.707@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433ECF0B60@DBDE01.ent.ti.com>
 <51095C7A.9080904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41531 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab3AaLSA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 06:18:00 -0500
In-Reply-To: <51095C7A.9080904@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Wed, Jan 30, 2013 at 23:16:34, Hunter, Jon wrote:
> 
> Ok fair enough. By the way, I posted a patch today [1] that will use the
> hwmod name as the clockevent timer name. Care to try on top of that
> patch and then we can eliminate the sprintf.
> 

Thanks. Will try it out later today.

Regards,
Vaibhav

