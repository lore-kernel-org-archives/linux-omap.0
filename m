From: "Nagendra" <nagendra@mistralsolutions.com>
Subject: OMAP3 - PM - Question - Disabling CLKEN and HFCLKOUT signals from TWL4030 scripts
Date: Fri, 21 Jan 2011 14:14:30 +0530
Message-ID: <005301cbb947$6d682730$48387590$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64556 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1AUIo1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 03:44:27 -0500
Received: by gxk9 with SMTP id 9so459145gxk.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 00:44:26 -0800 (PST)
Content-Language: en-us
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ratheesh@mistralsolutions.com

Hi All,

We are working on Power management on OMAP3 (3530) and I am trying to
disable CLKEN and HFCLKOUT through TWL4030 power scripts. However we have
not been able to achieve this. 

Following are the changes and tests done so far.

- VAUX1, CLKEN and HFCLKOUT were assigned to P1 group. 
- Wrote Singular messages to turn on/off these signals in TWL4030 scripts. 
- We observed that VAUX1 is able to switch ON/OFF properly as per the script
but HFCLKOUT and CLKEN are not behaving as expected. 
- However if we try writing CLKEN_DEV_GRP to zero, CLKEN is going low. 
- We have made sure that SYS_OFF_MODE and CLK_REQ signals go low during the
system OFF mode, LVL_WAKEUP bit enabled in Px_SW_EVENTS, and STS_CHG bit in
STS_HW_CONDITIONS is zero. 

Is there anything that I am missing? Kindly let me know. 

Part number of TPS used in our board is TPS65950 BZXNR

with regards,
- Nagendra.



