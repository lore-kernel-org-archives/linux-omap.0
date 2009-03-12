From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 0/1] DSPBRIDGE Fix for auto image load updated
Date: Thu, 12 Mar 2009 17:32:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A8F2C339@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35057 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbZCLMDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 08:03:53 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2CC3aZW029117
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 07:03:44 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2CC3Yhj016588
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 17:33:34 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>

All,
There was a typo in the previous patch set to fix dsp image autoloading, 
This is an updated patch set to fix issues observed with dsp image autoloading.
Can be applied along with the other DSPBRIDGE patches, validated on OMAP3430 SDP.


 drivers/dsp/bridge/rmgr/drv_interface.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

Regards
Ramesh Gupta G