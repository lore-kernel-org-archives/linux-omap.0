From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: iNAND on ZOOM2
Date: Fri, 13 Mar 2009 11:32:02 -0500
Message-ID: <003f01c9a3f9$3d0d3630$544ff780@am.dhcp.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CBBE1D25@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC35608702EA75D5CF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52958 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759421AbZCMQcM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Mar 2009 12:32:12 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2DGW57j004671
	for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2009 11:32:10 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702EA75D5CF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Pandita, Vikram'" <vikram.pandita@ti.com>, "'Kandasamy, ShankarGanesh'" <shankarganesh@ti.com>, linux-omap@vger.kernel.org

Hi,

The device present on Zoom2 is an eMMC.

I have seen some issues with respect to eMMC on the Zoom2 platforms. I have
seen the below error some times. But mostly the reads worked fine and the
device was recognized but any write attempt to card used to generate DATA
CRC errors.

I have tested an iNAND device on an other platform with the same driver.
That device seems to work fine though.

Regards,
Madhu


-----Original Message-----
From: Pandita, Vikram [mailto:vikram.pandita@ti.com] 
Sent: Friday, March 13, 2009 7:39 AM
To: Kandasamy, ShankarGanesh; linux-omap@vger.kernel.org; Chikkature
Rajashekar, Madhusudhan
Subject: RE: iNAND on ZOOM2 

Madhu
 Can you comment on your experience with EMMC.


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Kandasamy, ShankarGanesh
>Sent: Friday, March 13, 2009 7:37 AM
>To: linux-omap@vger.kernel.org
>Subject: iNAND on ZOOM2
>
>Hi all,
>I am trying to access iNAND on ZOOM2 . I enabled MMC2 on kernel Config.
Still, i am not able to
>access iNAND. , getting error -110 whilst initializing MMC
>Can anyone guide me how to enable access for iNAND on MDK-II platforms ?
>
>mmc0: host does not support reading read-only switch. assuming
write-enable.
>mmc0: new high speed SD card at address a9e9
>mmcblk0: mmc0:a9e9 SD02G 1966080KiB
> mmcblk0: p1 p2
>mmc1: error -110 whilst initialising MMC card
>EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
>
>
>PS : Kernel created from latest branch of
http://git.omapzoom.org/repo/omapkernel.git
>
>
>With Thanks & Regards ,
>ShankarGanesh
>CSST Team--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


