From: Deepa Raj <draj187@hotmail.com>
Subject: Questions about enabling dps(dynamic power switching) and SLM
Date: Wed, 13 Aug 2014 13:08:45 +0000
Message-ID: <BLU185-W2233E35F6629F6D4F137D6ECEB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from blu004-omc1s37.hotmail.com ([65.55.116.48]:62902 "EHLO
	BLU004-OMC1S37.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751145AbaHMNNx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Aug 2014 09:13:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I am working on OMAP3 and OMaP4. I know we can do AVS by smartreflex. T=
he Questions are as follows:

1) I have gone through TRM but could not find how can we enable/disable=
 dps and slm. Can you please point out how can we do that?=A0

2) Does DPS and SLM only applies to MPU,IVA and core domains or it appl=
ies to all devices?

3) According to OMAP ppt, DPS (similar like run time power management a=
nd having wakeup latency in micro seconds). If we enable DPS, does hard=
ware take care of switching on/off power domains means there is no need=
 of powering on/off devices through software?

4) Will DPS only triggers to retention state only or off state also?

5) If we enable SLM (according to omap ppt, suspend to ram) but wakeup =
latencies in milliseconds, if we enable this feature, does the hardware=
 be able to power off all the devices when system is idle or it only ap=
plies to VDD1 (MPU-IVA) or VDD2 (Core domain)?

Hope to see answers from experts.

Regards
d raj.


 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
