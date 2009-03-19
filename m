From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE: Set __GFP_RECLAIMABLE for reloading
 bridge module
Date: Thu, 19 Mar 2009 07:34:50 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF6439DB@dlee02.ent.ti.com>
References: <1237455476-29196-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58674 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbZCSMfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 08:35:03 -0400
In-Reply-To: <1237455476-29196-1-git-send-email-Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Thursday, March 19, 2009 11:38 AM
> To: Kanigeri, Hari
> Cc: Guzman Lugo, Fernando; ameya.palande@nokia.com; Menon, Nishanth;
> Gupta, Ramesh; linux-omap@vger.kernel.org; Hiroshi DOYU
> Subject: [PATCH 1/1] DSPBRIDGE: Set __GFP_RECLAIMABLE for reloading bridge
> module
> 
> To restart DSP system after DSP crash, reloading bridge module is
> necessary and a high order page allocation may fail after long use
> time because of memory fragmentation. To avoid this, mark it as
> reclaimable for immediate reloading.
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Thanks Hiroshi.

Tested-by: Nishanth Menon <nm@ti.com>

Test h/w: SDP3430. - OMAP3430 ES3.0

Test iteration:
insmod  ./bridgedriver.ko shm_size=0x400000 phys_mempool_base=0 base_img=/lib/dsp/baseimage.dof
rmmod bridgedriver
--

Num iterations: 25K

Regards,
Nishanth Menon
