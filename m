From: "Ramesh Gupta G" <x0023949@dbdmail.itg.ti.com>
Subject: Re: [PATCH] OMAP2/3 PM: Add OMAP PM no-op layer
Date: Tue, 24 Jun 2008 19:16:11 +0530
Message-ID: <008501c8d600$af13e5c0$8cdfa8c0@ent.ti.com>
References: <20080617145905.20886.89236.stgit@localhost.localdomain> <20080617150122.20886.9290.stgit@localhost.localdomain> <0f2a01c8d153$8e39c2e0$11dfa8c0@ent.ti.com> <alpine.DEB.1.00.0806182351160.24288@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35422 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754208AbYFXNvt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2008 09:51:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Ramesh Gupta G <x0023949@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, h-kanigeri2@ti.com, jouni.hogander@nokia.com, khilman@mvista.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, vpasam@ti.com

Hello Paul,

>> Will this interface provides information of max number if OPPs supported 
>> and
>> the frequency corresponding to eah OPP level?
>
> It could be added.  This is for DSPBridge use, not for the MPU, correct?
> Is the idea essentially to replace the vdd1_dsp_freq[] array in
> mpu_driver/src/rmgr/linux/common/drv_interface.c?

Yes, this is to replace the  table in drv_interface.c

>Can you tell me what
> each of the 4 fields in vdd1_dsp_freq[] means?

The 4 fileds of vdd1_freq[] are as below.

voltage
opp frequency
min frequency
max frequency

we are currently not using the field 'voltage', this is for future usage.
the min_frequency and max_frequency are threshold frequencies set by DSP and 
are configurable.

>
> Perhaps something similar to an OMAP PM function
> "omap_pm_dsp_get_opp_table()" that DSPBridge could call on startup?
>

Sure, we can call this function on startup.

>> MPU Bridge is required to inform the DSP about OPP level change for load
>> predictor use in DSP; this is done as part of in post notification in
>> dspbridge. Do we have support for Post Notification in this framework?
>
> I just posted some patches for that a few days ago.  You should be able to
> use those to notify DSPBridge of changes to iva2_ck.

Thanks for that, we will look into that.

Also can you please provide the tentative dates these patches are avialable 
with above changes.

Please let us know your comments.

regards
Ramesh Gupta G

