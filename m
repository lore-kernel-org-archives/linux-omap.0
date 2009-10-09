From: Nishanth Menon <nm@ti.com>
Subject: Re: FEATURES prints
Date: Fri, 9 Oct 2009 09:15:08 -0500
Message-ID: <4ACF456C.8080109@ti.com>
References: <4ACE39CC.1070906@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301DDD763EB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53457 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760889AbZJIOPu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Oct 2009 10:15:50 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n99EF9VV020470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 9 Oct 2009 09:15:09 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n99EF9Ee027458
	for <linux-omap@vger.kernel.org>; Fri, 9 Oct 2009 09:15:09 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n99EF9jH021948
	for <linux-omap@vger.kernel.org>; Fri, 9 Oct 2009 09:15:09 -0500 (CDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDD763EB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev had written, on 10/09/2009 05:46 AM, the following:
>> -----Original Message-----
>> From: Menon, Nishanth 
>> Sent: Friday, October 09, 2009 12:43 AM
>> To: Premi, Sanjeev; linux-omap@vger.kernel.org
>> Subject: FEATURES prints
>>
>> Folks,
>>
>> With the addition of FEATURES in l-o, the following prints:
>>   - l2cache : Y
>>   - iva : Y
>>   - sgx : Y
>>   - neon : Y
>>   - isp : Y
>>
>> comes up on SDP3430 -> now that we will introduce half a 
>> dozen features 
> 
> [sp] The intention here is to print the features that help in
>      identifying the processor. Not really the board/EVM.
>      Even if there are more features, we decide which ones to
>      show.
this still a bunch of noise which is unusable for applications -> e.g. 
if an app wanted to use ISP, how would it do it?


-- 
Regards,
Nishanth Menon
