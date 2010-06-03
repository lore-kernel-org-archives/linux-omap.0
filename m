From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 3/9] OMAP2/3/4 : Dual mode timer device registration.
Date: Thu, 3 Jun 2010 15:00:50 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323207CFC@dbde02.ent.ti.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
 <1275143831-7629-2-git-send-email-thara@ti.com>
 <1275143831-7629-3-git-send-email-thara@ti.com>
 <1275143831-7629-4-git-send-email-thara@ti.com> <4C02EE9F.70305@ti.com>
 <20100601092030.GH841@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48347 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933584Ab0FCJa6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 05:30:58 -0400
In-Reply-To: <20100601092030.GH841@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Tony Lindgren [mailto:tony@atomide.com]
>>Sent: Tuesday, June 01, 2010 2:51 PM
>>To: Cousson, Benoit
>>Cc: Gopinath, Thara; linux-omap@vger.kernel.org; khilman@deeprootsystems.com; Sawant, Anand
>>Subject: Re: [PATCH 3/9] OMAP2/3/4 : Dual mode timer device registration.
>>
>>* Benoit Cousson <b-cousson@ti.com> [100531 01:57]:
>>> >+
>>> >+#define NO_EARLY_TIMERS                        2
>>> The "NO_" is a little bit confusing, you should maybe use _COUNT.
>>
>>Also NR_ is commonly used.

I will fix this in the repost

>>
>>Tony
