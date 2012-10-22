From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 3/5] ARM: OMAP2+: powerdomain/PRM: move the low-level
 powerdomain functions into PRM
Date: Mon, 22 Oct 2012 05:57:02 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB47015@DBDE01.ent.ti.com>
References: <20121015224455.18306.89030.stgit@dusk.lan>
 <20121015230542.18306.88940.stgit@dusk.lan> <507FAAD7.6030209@ti.com>
 <alpine.DEB.2.00.1210201747550.27264@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40137 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627Ab2JVF5K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 01:57:10 -0400
In-Reply-To: <alpine.DEB.2.00.1210201747550.27264@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Dill, Russ" <russ.dill@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Oct 20, 2012 at 23:20:18, Paul Walmsley wrote:
> 
> Hi Rajendra, Russ, Santosh,
> 
> thanks for your Reviewed-bys and acks and comments.  Have folded them into 
> the series here.  Russ, the file headers have been updated per your 
> comments.  Also while there, the copyrights from the 
> {clock,power}domainxxxx.c files were copied in, along with Rajendra's 
> authorship line.
> 

Sorry for delayed response,

I have just tested it on Beaglebone platform without any issues. I tested 
your branch 
"prm_cm_split_cleanup_3.8" + gpmc patch from Jon (already in linus/master).

So to this compete patch-series,

Reviewed-Acked-Tested-By: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav

> 
> - Paul
> 

