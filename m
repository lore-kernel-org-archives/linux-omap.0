From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
Date: Wed, 27 Aug 2008 09:34:37 -0500
Message-ID: <8AA5EFF14ED6C44DB31DA963D1E78F0DB9195644@dlee02.ent.ti.com>
References: <52895.192.168.10.89.1218460298.squirrel@dbdmail.itg.ti.com>
 <200808271409.m7RE9SgN017140@dbdp31.itg.ti.com>
 ,<B85A65D85D7EB246BE421B3FB0FBB59301A01EBC4F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35260 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbYH0Ojh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 10:39:37 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7REdVb6001593
	for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 09:39:36 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301A01EBC4F@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Romit,

>________________________________________
>From: Dasgupta, Romit
>Sent: Wednesday, August 27, 2008 9:18 AM
>To: Dasgupta, Romit; Gupta, Ramesh; Nayak, Rajendra; linux-omap@vger.kernel.org
>Suject: RE: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver

>Sorry, missed the link
>http://softwarecommunity.intel.com/articles/eng/1611.htm. Search for "The Userspace Governor"

Do we have userspace governor implemented? I am not seeing userspace governor with below command.

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
ondemand performance

Thanks 
Ramesh Gupta G