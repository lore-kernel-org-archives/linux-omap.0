From: "Kandasamy, ShankarGanesh" <shankarganesh@ti.com>
Subject: iNAND on ZOOM2
Date: Fri, 13 Mar 2009 18:07:15 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CBBE1D25@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41755 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbZCMMhZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 08:37:25 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2DCbHBf023000
	for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2009 07:37:23 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2DCbGjr013024
	for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2009 18:07:16 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,
I am trying to access iNAND on ZOOM2 . I enabled MMC2 on kernel Config. Still, i am not able to access iNAND. , getting error -110 whilst initializing MMC
Can anyone guide me how to enable access for iNAND on MDK-II platforms ?

mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new high speed SD card at address a9e9
mmcblk0: mmc0:a9e9 SD02G 1966080KiB
 mmcblk0: p1 p2
mmc1: error -110 whilst initialising MMC card
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended


PS : Kernel created from latest branch of  http://git.omapzoom.org/repo/omapkernel.git


With Thanks & Regards ,
ShankarGanesh 
CSST Team