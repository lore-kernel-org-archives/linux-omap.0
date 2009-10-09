From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: FEATURES prints
Date: Fri, 9 Oct 2009 16:16:41 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDD763EB@dbde02.ent.ti.com>
References: <4ACE39CC.1070906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60557 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759662AbZJIKr3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 06:47:29 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n99AkoRE001717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 9 Oct 2009 05:46:52 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n99AknWH007874
	for <linux-omap@vger.kernel.org>; Fri, 9 Oct 2009 16:16:49 +0530 (IST)
In-Reply-To: <4ACE39CC.1070906@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Friday, October 09, 2009 12:43 AM
> To: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: FEATURES prints
> 
> Folks,
> 
> With the addition of FEATURES in l-o, the following prints:
>   - l2cache : Y
>   - iva : Y
>   - sgx : Y
>   - neon : Y
>   - isp : Y
> 
> comes up on SDP3430 -> now that we will introduce half a 
> dozen features 

[sp] The intention here is to print the features that help in
     identifying the processor. Not really the board/EVM.
     Even if there are more features, we decide which ones to
     show.

> here and there, we will soon clutter this up. we should introduce a 
> sysfs entry + remove the above noise..

[sp] I believe the sysfs would be good for board level features.

> 
> any comments?
> 
> -- 
> Regards,
> Nishanth Menon
> 