From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE Fix flush_workque
Date: Thu, 19 Mar 2009 07:40:52 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF6439E2@dlee02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A91ACA75@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34084 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303AbZCSMlF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 08:41:05 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2JCewFl017509
	for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2009 07:41:03 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A91ACA75@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Varide, Nischal" <nischal.varide@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

> -----Original Message-----
> From: Gupta, Ramesh
> Sent: Thursday, March 19, 2009 6:25 AM
> To: linux-omap@vger.kernel.org
> Cc: Menon, Nishanth; Kanigeri, Hari; Varide, Nischal; Guzman Lugo,
> Fernando
> Subject: [PATCH 1/1] DSPBRIDGE Fix flush_workque
> 
> From a8aabc6233329998d0ac62be42ade5a77f03ef2a Mon Sep 17 00:00:00 2001
> From: Ramesh Gupta <x0023949@ti.com>
> Date: Thu, 19 Mar 2009 09:56:30 +0530
> Subject: [PATCH 1/1] DSPBRIDGE Fix flush_workque
> 
> Observed some crash with flush_workque after
> multiple load and unload.
> Replaced flush_workque with destroy_workque
> 
> Signed-off-by: Varide Nischal <x0102224@ti.com>
Thanks Ramesh.
Tested-by: Nishanth Menon <nm@ti.com>

Test h/w: SDP3430. - OMAP3430 ES3.0 

Test iteration: (bootargs mem=122M)
./bridgedriver.ko phys_mempool_base=0x87A00000 phys_mempool_size=0x00600000  base_img=dsp/baseimage.dof
rmmod bridgedriver
--

Num iterations: 30K

Regards,
Nishanth Menon
