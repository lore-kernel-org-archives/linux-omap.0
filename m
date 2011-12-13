From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Trying to boot Panda with DT
Date: Tue, 13 Dec 2011 14:27:33 +0100
Message-ID: <4EE752C5.50804@ti.com>
References: <1323781385.1877.75.camel@deskari> <4EE7512C.6010207@ti.com> <4EE75260.3070700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48996 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab1LMN1g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 08:27:36 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBDDRZvA019972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 07:27:36 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pBDDRZar006375
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 07:27:35 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBDDRZS2000561
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 07:27:35 -0600 (CST)
In-Reply-To: <4EE75260.3070700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap mailing list <linux-omap@vger.kernel.org>

On 12/13/2011 2:25 PM, Rajendra Nayak wrote:
> On Tuesday 13 December 2011 06:50 PM, Cousson, Benoit wrote:
>>
>> I've just sent a patch to add the default DT config for OMAP. It will
>> add these config into the OMAP2plus Kconfig.
>>
>> + select USE_OF
>> + select ARM_APPENDED_DTB
>> + select ARM_ATAG_DTB_COMPAT
>> + select PROC_DEVICETREE
>>
>> In theory ARM_APPENDED_DTB and ARM_ATAG_DTB_COMPAT should not be needed
>> in your case but only for legacy u-boot.
>> It should not messed up the DT in case of DT aware uboot, but it worst
>> checking if this is the case.
>
> I don't think thats a problem as I have those options enabled and am
> able to boot with the DT aware uboot.

OK cool, I was not sure but that's much better...
Let's assume that this is due to a broken u-boot then :-)

Thanks,
Benoit


