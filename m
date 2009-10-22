From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] OMAP3:PM:Fix for Silicon bug on Context restore on
 OMAP3430
Date: Thu, 22 Oct 2009 02:39:03 -0500
Message-ID: <4AE00C17.3090900@ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA23E5A7@dbde02.ent.ti.com> <87y6n4onxq.fsf@deeprootsystems.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A511127@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46505 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZJVHi7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 03:38:59 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A511127@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Gulati, Shweta" <shweta.gulati@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Gopinath, Thara had written, on 10/22/2009 01:49 AM, the following:
>>>>
>>>> +config DELAY_IN_PADCONF_SAVE
>>>> +	bool "Insert 300 us delay after the start of padconf saving"
>>>> +	depends on ARCH_OMAP3 && PM
>>>> +	help

Apologies, one last tiny little comment :).. does this impact ALL OMAP3 
variants such as 35xx,36xx as well as 34xx??

-- 
Regards,
Nishanth Menon
