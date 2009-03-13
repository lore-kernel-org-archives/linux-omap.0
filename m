From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: iNAND on ZOOM2
Date: Fri, 13 Mar 2009 18:09:24 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702EA75D5CF@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CBBE1D25@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54175 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbZCMMjh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 08:39:37 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2DCdQTQ032028
	for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2009 07:39:32 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CBBE1D25@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kandasamy, ShankarGanesh" <shankarganesh@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

Madhu
 Can you comment on your experience with EMMC.


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Kandasamy, ShankarGanesh
>Sent: Friday, March 13, 2009 7:37 AM
>To: linux-omap@vger.kernel.org
>Subject: iNAND on ZOOM2
>
>Hi all,
>I am trying to access iNAND on ZOOM2 . I enabled MMC2 on kernel Config. Still, i am not able to
>access iNAND. , getting error -110 whilst initializing MMC
>Can anyone guide me how to enable access for iNAND on MDK-II platforms ?
>
>mmc0: host does not support reading read-only switch. assuming write-enable.
>mmc0: new high speed SD card at address a9e9
>mmcblk0: mmc0:a9e9 SD02G 1966080KiB
> mmcblk0: p1 p2
>mmc1: error -110 whilst initialising MMC card
>EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
>
>
>PS : Kernel created from latest branch of  http://git.omapzoom.org/repo/omapkernel.git
>
>
>With Thanks & Regards ,
>ShankarGanesh
>CSST Team--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

