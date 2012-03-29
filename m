From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
Date: Thu, 29 Mar 2012 14:32:34 +0530
Message-ID: <4F74252A.7060809@ti.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com> <79CD15C6BA57404B839C016229A409A83183E0CE@DBDE01.ent.ti.com> <4F73FD52.60209@ti.com> <79CD15C6BA57404B839C016229A409A83183FB9F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:47733 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751178Ab2C2JCl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Mar 2012 05:02:41 -0400
Received: by obbta14 with SMTP id ta14so3091220obb.0
        for <linux-omap@vger.kernel.org>; Thu, 29 Mar 2012 02:02:40 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83183FB9F@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thursday 29 March 2012 02:26 PM, Hiremath, Vaibhav wrote:
> The point I was trying to make here was, cpu_is_xxx() check will become ugly,
> as more and more devices gets added to the list, am33xx being the first one
> in omap34xx family.

So are there more, other than AM33xx which are cortex A8 based but
share the OMAP4 PRCM IP block?
