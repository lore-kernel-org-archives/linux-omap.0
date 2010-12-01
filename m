From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 4/5 v2] OMAP3630: PM: Disable L2 cache while invalidating
 L2 cache
Date: Wed, 01 Dec 2010 08:38:59 -0600
Message-ID: <4CF65E03.103@ti.com>
References: <1291061993-4740-1-git-send-email-nm@ti.com>	<1291061993-4740-5-git-send-email-nm@ti.com>	<AANLkTim9dQ2Vw06_QSDVm1S92TkkS-cRHh+HNAp_qk-W@mail.gmail.com>	<4CF507CF.30909@ti.com> <AANLkTi=_w=Rg1Xaj0W0zPbJjMoRaruEAdNux1k8NWz8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35725 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755434Ab0LAOjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 09:39:03 -0500
Received: by vws18 with SMTP id 18so2509206vws.21
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 06:39:02 -0800 (PST)
In-Reply-To: <AANLkTi=_w=Rg1Xaj0W0zPbJjMoRaruEAdNux1k8NWz8d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: TAO HU <tghk48@motorola.com>
Cc: TAO HU <taohu@motorola.com>, linux-omap <linux-omap@vger.kernel.org>, Jean <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Vishwa <vishwanath.bs@ti.com>

TAO HU had written, on 12/01/2010 02:56 AM, the following:
> Do we need to implement the same thing in bootloader?
> I.e. Do we need to disable L2 prior invalidating L2 for  OMAP3630 1st boot up?
Though out of context for this email list (linux kernel :)), I believe 
it wont hurt to do this as a standard procedure.
---
Regards,
Nishanth Menon
