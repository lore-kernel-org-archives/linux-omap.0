From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: Re: Issue with setting vdd2_opp level to 3 through OMAP3 SRF API's
Date: Thu, 17 Sep 2009 19:20:58 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31AD56@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31AD50@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31AD52@dbde02.ent.ti.com>,<5A47E75E594F054BAF48C5E4FC4B92AB030A12BF82@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31AD53@dbde02.ent.ti.com>,<5A47E75E594F054BAF48C5E4FC4B92AB030A12BFA8@dbde02.ent.ti.com>,<EAF47CD23C76F840A9E7FCE10091EFAB02BA31AD55@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48369 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754281AbZIQNu5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Sep 2009 09:50:57 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8HDox9m024409
	for <linux-omap@vger.kernel.org>; Thu, 17 Sep 2009 08:51:00 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8HDoxJ6022791
	for <linux-omap@vger.kernel.org>; Thu, 17 Sep 2009 19:20:59 +0530 (IST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31AD55@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

The format of calling resource_rerquest for vdd2 opp setting is 
resource_request("vdd2_opp", dev, r);
where r is the throughput. 
Example, in set_opp, if vdd1 opp is >= 3, vdd2 opp is being set to 3.

The above means "resource_request" expects "targeted level" 
for all types of OPP/Freq resources except for "vdd2_opp". 
Only for vdd2_opp we need to give the "throughput required" 
and not the "targeted level". Is that correct?

API needs to be generic. If my above understanding is correct, 
why "resource_request" is expecting an unique kind of 
input parameter, only for vdd2_opp resource?

Thanks,
V Charu Latha
_______________________________________
From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Varadarajan, Charu Latha
Sent: Thursday, September 17, 2009 2:55 PM
To: linux-omap@vger.kernel.org
Subject: Issue with setting vdd2_opp level to 3 through OMAP3 SRF API's

Hello,
When trying to make "vdd2_opp" resource to "VDD2_OPP3" level using "resource_request"(arch\arm\plat-omap\resource.c), it is observed that vdd2_opp is always put to VDD2_OPP2 level.

Code Snippet:
For the above, set_opp() in arch\arm\mach-omap2\resource34xx.c is called with a target level of 3.  The code flow is as given below:
/*********************** Code Snippet Start****************************/
else if (resp == vdd2_resp) {
                tput = target_level;

                /* Convert the tput in KiB/s to Bus frequency in MHz */
                req_l3_freq = (tput * 1000)/4;

                for (ind = 2; ind <= MAX_VDD2_OPP; ind++){
                        if ((l3_opps + ind)->rate >= req_l3_freq) {
                                target_level = ind;
                                break;
                        }
                }
                /* Set the highest OPP possible */
                if (ind > MAX_VDD2_OPP)
                        target_level = ind-1;
                resource_set_opp_level(VDD2_OPP, target_level, 0);
        }
/*********************** Code Snippet End****************************/

Analysis:
During execution,
tout = 3;
req_l3_freq = 750;
when ind = 2, if ((l3_opps + ind)->rate >= req_l3_freq) ==> (83M > 750) which in turn makes target_level = 2.
Hence while requesting for target_level of 3, vdd2_opp is made to target_level = 2, which is incorrect.

Issues observed:
The above code should have been made for mapping L3 freq 83MHz to VDD2_OPP2 and L3 freq 166MHz to VDD2_OPP3. But the above code would always make vdd2_opp to VDD2_OPP2 level. However, it is observed that, if we change the vdd2_opp to 3 using sysfs, it seems to be setting to level 3. I am wondering if there are any issues with sysfs entries since same is working with resource frame work API's.

Please let me know if my understanding is wrong.

Thanks & Regards,
V Charu Latha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

