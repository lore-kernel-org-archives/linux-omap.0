From: Manoharan Vijaya Raghavan <thenewsymbol@gmail.com>
Subject: TI OMAP4430 - UHS support
Date: Mon, 24 Oct 2011 08:56:07 +0000 (UTC)
Message-ID: <loom.20111024T105435-408@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:48450 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab1JXJAI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Oct 2011 05:00:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RIGO6-00039h-Tt
	for linux-omap@vger.kernel.org; Mon, 24 Oct 2011 11:00:07 +0200
Received: from 125.19.39.117 ([125.19.39.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 24 Oct 2011 11:00:06 +0200
Received: from thenewsymbol by 125.19.39.117 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 24 Oct 2011 11:00:06 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, 
 
I need your help in writing a UHS-I driver for OMAP4430.
I would like to know the feasibility in implementing a UHS-I driver (for SD 
card) in OMAP4430. (I am using Pandaboard).
The purpose is to have readspeed more than 40MB/s for SD cards (Which as per 
the SD card specification 3.01 is possible only in UHS-I mode).
For this I see that OMAP4430 supports 1.8V and DDR50 mode also. 
 
 
Please let me know your informed opinion about whether UHS-I can be 
implemented for Pandaboard. 
 
I am having trouble in switching to UHS-I mode in Pandaboard. 
Following are my queries. 
 
I am using an SD card which does support UHS-I mode. (Sandisk UHS Extreme Pro 
(45 MB/s quoted speed))
 
I am trying to switch the card to UHS mode by first sending a ACMD41. 
                   For this I have modified the mmc_send_app_op_cond () in 
drivers/mmc/core/sd_ops.c to set the S18R bit. 
                   And in the response from the SD card I see that S18A bit is 
set. 
After this response response from the SD Card I am sending CMD11 to SD Card. 
 
After receiving the response from SD Card I am changing the SDVS in MMCHS_HCTL 
to 0x5 which is for 1.8V.(As per mentioned in the Specification).
However I am not able to read the DLEV as 0xF from PSTATE register as per 
mentioned in the OMAP4430 specification.
 
Please let me know what I might be missing. 
 
Is there is a possbility that we could achieve 40MB/s of read speed in SD mode 
without using the UHS-I ? 
We see in the spec that it does support upto 48MB/s in DDR mode. 
But as per the SD card specification 3.01 DDR mode is supported only in UHS-I 
mode. 
This is the reason I am trying to switch the card to UHS-I mode.
Please let me know  if there is a way to use DDR mode in Pandaboard for SD 
card without having to switch to UHS-I to achieve read speeds of around 40MB/s.
 
with thanks,
V.Manoharan

