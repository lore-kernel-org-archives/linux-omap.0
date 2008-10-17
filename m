From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH 01/04] OMAP3 SRF: Generic shared resource f/w
Date: Fri, 17 Oct 2008 16:31:08 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B038EC1A@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B038E9DC@dbde02.ent.ti.com>
 <02bd01c9302c$1e630570$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36191 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672AbYJQLBU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 07:01:20 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9HB1DY9007630
	for <linux-omap@vger.kernel.org>; Fri, 17 Oct 2008 06:01:19 -0500
In-Reply-To: <02bd01c9302c$1e630570$LocalHost@wipultra1382>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Some more points can be noted

resource_init function is not prefixed by __init

>>
>> >> 1) curr_level of the shared_resource is not updated in
>> >> update_resource_level
>> >
>> >Yes, its not. Its done as part of the platform specific
>> change_level call.
>>
>> [Romit] Kindly see below. I was thinking that it is better
>> that we do not access any fields of struct shared_resource
>> from outside this file. Would the line below solve the problem?
>
>The actual *target_level* of the resource will depend on the resource type.
>Hence for say a "per_pwrdm_latency" resource if some user request's for a
>latency of no more than 130ms, it inturn translates to a PWRDM_RET level
>depending on the specific latency to go to RET/OFF.
>
>So what is currently done is the current_level of the resource in the above case
>is set to PWRDM_RET and if done the way you are suggesting will be set to 130ms.
[Romit] I agree that the curr_level/target_level will depend on the resource type and that is why it seems to be inside struct shared_resource. Anyway in the update_resource_level function the code is trying to find the maximum target level among the users of the resource. So I am not very clear why it can't be done as I mentioned earlier. Kindly see my replies to other patches you posted. 


