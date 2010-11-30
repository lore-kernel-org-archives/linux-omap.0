From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 4/5 v2] OMAP3630: PM: Disable L2 cache while invalidating
 L2 cache
Date: Tue, 30 Nov 2010 08:18:55 -0600
Message-ID: <4CF507CF.30909@ti.com>
References: <1291061993-4740-1-git-send-email-nm@ti.com>	<1291061993-4740-5-git-send-email-nm@ti.com> <AANLkTim9dQ2Vw06_QSDVm1S92TkkS-cRHh+HNAp_qk-W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34444 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753074Ab0K3OS7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 09:18:59 -0500
Received: by mail-gw0-f43.google.com with SMTP id 17so2645253gwb.30
        for <linux-omap@vger.kernel.org>; Tue, 30 Nov 2010 06:18:58 -0800 (PST)
In-Reply-To: <AANLkTim9dQ2Vw06_QSDVm1S92TkkS-cRHh+HNAp_qk-W@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: TAO HU <tghk48@motorola.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Vishwa <vishwanath.bs@ti.com>

TAO HU had written, on 11/30/2010 12:03 AM, the following:
> What would happen without this patch? L2 data corruption after back
> from OFF mode?
> 
I believe yes.

-- 
Regards,
Nishanth Menon
