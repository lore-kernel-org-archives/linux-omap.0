From: TAO HU <tghk48@motorola.com>
Subject: Re: [PATCH 4/5 v2] OMAP3630: PM: Disable L2 cache while invalidating
 L2 cache
Date: Wed, 1 Dec 2010 16:56:22 +0800
Message-ID: <AANLkTi=_w=Rg1Xaj0W0zPbJjMoRaruEAdNux1k8NWz8d@mail.gmail.com>
References: <1291061993-4740-1-git-send-email-nm@ti.com>
	<1291061993-4740-5-git-send-email-nm@ti.com>
	<AANLkTim9dQ2Vw06_QSDVm1S92TkkS-cRHh+HNAp_qk-W@mail.gmail.com>
	<4CF507CF.30909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:53682 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab0LAI4Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 03:56:25 -0500
Received: from il06vts04.mot.com (il06vts04.mot.com [129.188.137.144])
	by mdgate1.mot.com (8.14.3/8.14.3) with SMTP id oB18uRg6016685
	for <linux-omap@vger.kernel.org>; Wed, 1 Dec 2010 01:56:27 -0700 (MST)
Received: from mail-ey0-f182.google.com (mail-ey0-f182.google.com [209.85.215.182])
	by mdgate1.mot.com (8.14.3/8.14.3) with ESMTP id oB18uQil016663
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Wed, 1 Dec 2010 01:56:27 -0700 (MST)
Received: by eyb7 with SMTP id 7so30290041eyb.27
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 00:56:22 -0800 (PST)
In-Reply-To: <4CF507CF.30909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: TAO HU <taohu@motorola.com>, linux-omap <linux-omap@vger.kernel.org>, Jean <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Vishwa <vishwanath.bs@ti.com>

Hi, Nishanth Menon

One more question.

Do we need to implement the same thing in bootloader?
I.e. Do we need to disable L2 prior invalidating L2 for  OMAP3630 1st boot up?

On Tue, Nov 30, 2010 at 10:18 PM, Nishanth Menon <nm@ti.com> wrote:
> TAO HU had written, on 11/30/2010 12:03 AM, the following:
>>
>> What would happen without this patch? L2 data corruption after back
>> from OFF mode?
>>
> I believe yes.
>
> --
> Regards,
> Nishanth Menon
>



-- 
Best Regards
Hu Tao
