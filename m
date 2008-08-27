From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
Date: Wed, 27 Aug 2008 19:47:07 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301A01EBC4E@dbde02.ent.ti.com>
References: <52895.192.168.10.89.1218460298.squirrel@dbdmail.itg.ti.com>
 <200808271409.m7RE9SgN017140@dbdp31.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56778 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbYH0ORS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 10:17:18 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7REH9sx002221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 09:17:17 -0500
In-Reply-To: <200808271409.m7RE9SgN017140@dbdp31.itg.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ramesh,
                 For scaling from userspace, you can move to the userspace governor. Kindly look into this article:


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Gupta, Ramesh
>Sent: Wednesday, August 27, 2008 7:39 PM
>To: Nayak, Rajendra; linux-omap@vger.kernel.org
>Subject: RE: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
>
>Hi,
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rajendra Nayak
>> Sent: Monday, August 11, 2008 6:42 PM
>> To: linux-omap@vger.kernel.org
>> Subject: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
>>
>> Hi,
>>
>> The patch which follows implements the CPUFreq driver for
>> OMAP3, tested on 3430sdp.
>> The driver uses API's defined as part of the OMAP-PM layer.
>>
>> Performance Governor is selected by default in the defconfig.
>> After bootup, to switch to ondemand or any other governor use
>> the following sysfs interface
>> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
>
>With the ondemand Governor  I am some seeing issues for DSP Bridge.
>clk_notifier_register call for iva2_ck is successful but I am seeing below messages
>on opp change request from IVA.
>
><3>clock: Could not find fieldval 0 for clock iva2_ck parent dpll2_m2_ck
>clock: Could not find fieldval 0 for clock iva2_ck parent dpll2_m2_ck
><3>clock: Could not find fieldval 0 for clock iva2_ck parent dpll2_m2_ck
>clock: Could not find fieldval 0 for clock iva2_ck parent dpll2_m2_ck
>
>Looks like access to memory stalls while opp is changing ( some times I observed
>MMU Fault messages from IVA while opp is changing). Also some times I observed
>that after the opp change IVA Power state registers are not accessible( I am getting
>BUG# soft lock up while accessing IVA Power state registers).
>
>Can you please provide your inputs on these issues?
>
>Is there any way to manually switch opp using sysfs?( useful for debugging)
>
>regards
>Ramesh Gupta G
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

