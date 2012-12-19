From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 1/1] ARM: OMAP: Fix build breakage due to missing
 include in i2c.c
Date: Wed, 19 Dec 2012 06:50:57 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC9A2F4@DBDE01.ent.ti.com>
References: <1355899498-11442-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42046 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221Ab2LSGvA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 01:51:00 -0500
In-Reply-To: <1355899498-11442-1-git-send-email-vaibhav.bedia@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infrared.org" <linux-arm-kernel@lists.infrared.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Dec 19, 2012 at 12:14:58, Bedia, Vaibhav wrote:
> Merge commit 752451f (Merge branch 'i2c-embedded/for-next' of git://git.pengutronix.de/git/wsa/linux)
> resulted in a build breakage for OMAP
> 
> ...
> arch/arm/mach-omap2/i2c.c: In function 'omap_pm_set_max_mpu_wakeup_lat_compat':
> arch/arm/mach-omap2/i2c.c:130:2: error: implicit declaration of function 'omap_pm_set_max_mpu_wakeup_lat'
> make[1]: *** [arch/arm/mach-omap2/i2c.o] Error 1
> ...
> 
> Fix this by including the appropriate header file with the function prototype
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

I messed up the LAKML address in this version. Resent with the right address.
