From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2/3 PM: Add OMAP PM no-op layer
Date: Tue, 24 Jun 2008 01:33:23 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806182351160.24288@utopia.booyaka.com>
References: <20080617145905.20886.89236.stgit@localhost.localdomain> <20080617150122.20886.9290.stgit@localhost.localdomain> <0f2a01c8d153$8e39c2e0$11dfa8c0@ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53202 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbYFXHdY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 03:33:24 -0400
In-Reply-To: <0f2a01c8d153$8e39c2e0$11dfa8c0@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ramesh Gupta G <x0023949@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, h-kanigeri2@ti.com, jouni.hogander@nokia.com, khilman@mvista.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, vpasam@ti.com

Hello Ramesh, 

On Wed, 18 Jun 2008, Ramesh Gupta G wrote:

> Will this interface provides information of max number if OPPs supported and
> the frequency corresponding to eah OPP level?

It could be added.  This is for DSPBridge use, not for the MPU, correct?  
Is the idea essentially to replace the vdd1_dsp_freq[] array in 
mpu_driver/src/rmgr/linux/common/drv_interface.c?  Can you tell me what 
each of the 4 fields in vdd1_dsp_freq[] means?

Perhaps something similar to an OMAP PM function 
"omap_pm_dsp_get_opp_table()" that DSPBridge could call on startup?

> MPU Bridge is required to inform the DSP about OPP level change for load 
> predictor use in DSP; this is done as part of in post notification in 
> dspbridge. Do we have support for Post Notification in this framework?

I just posted some patches for that a few days ago.  You should be able to 
use those to notify DSPBridge of changes to iva2_ck.


- Paul
