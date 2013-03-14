From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: OMAP baseline test results for v3.9-rc1
Date: Thu, 14 Mar 2013 17:16:56 +0530
Message-ID: <5141B8B0.5050206@ti.com>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EC281B4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59274 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756768Ab3CNLpO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 07:45:14 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC281B4@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thursday 14 March 2013 04:59 PM, Hiremath, Vaibhav wrote:
> 
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Paul Walmsley
>> Sent: Tuesday, March 12, 2013 10:10 PM
>> To: linux-omap@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Subject: OMAP baseline test results for v3.9-rc1
>>
>>
>> Here are some basic OMAP test results for Linux v3.9-rc1.
>> Logs and other details at:
>>
>>     http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/
>>
>>
>> Test summary
>> ------------
>>
>> Build:
>>     FAIL ( 4/16): am33xx_only, omap1_defconfig,
> This requires some cleanup in Makefile and Kconfig handling,
> 
> Either you disable SMP support for non-SMP devices like AM33xx 
> 
> OR
> 
> Fix the Makefile to resolve the build dependencies (may not be trivial)
> 
This one... Better things is not to build the OMAP4 files for AM33XX only build.
Even if it is not trivial, its right way of fixing the issue.

Regards,
Santosh
