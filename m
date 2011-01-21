From: "Lesly A M" <leslyam@ti.com>
Subject: Re: OMAP3 - PM - Question - Disabling CLKEN and HFCLKOUT signals
     from TWL4030 scripts
Date: Fri, 21 Jan 2011 15:44:27 +0530 (IST)
Message-ID: <23149.10.24.255.17.1295604867.squirrel@dbdmail.itg.ti.com>
References: <005301cbb947$6d682730$48387590$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55299 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467Ab1AUKOa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 05:14:30 -0500
In-Reply-To: <005301cbb947$6d682730$48387590$@com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nagendra <nagendra@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org, ratheesh@mistralsolutions.com

Hi Nagendra,

> Hi All,
>
> We are working on Power management on OMAP3 (3530) and I am trying to
> disable CLKEN and HFCLKOUT through TWL4030 power scripts. However we have
> not been able to achieve this.
>
> Following are the changes and tests done so far.
>
> - VAUX1, CLKEN and HFCLKOUT were assigned to P1 group.
> - Wrote Singular messages to turn on/off these signals in TWL4030 scripts.
> - We observed that VAUX1 is able to switch ON/OFF properly as per the script
> but HFCLKOUT and CLKEN are not behaving as expected.
> - However if we try writing CLKEN_DEV_GRP to zero, CLKEN is going low.
> - We have made sure that SYS_OFF_MODE and CLK_REQ signals go low during the
> system OFF mode, LVL_WAKEUP bit enabled in Px_SW_EVENTS, and STS_CHG bit in
> STS_HW_CONDITIONS is zero.
>
> Is there anything that I am missing? Kindly let me know.

Did try probing the sys_clkreq from OMAP?
Are you sending SLEEP/OFF command in singular msg?
Also check the HFCLKOUT_REMAP register for SLEEP_STATE[3:0], if using SLEEP cmd.

Regards,
Lesly A M

>
> Part number of TPS used in our board is TPS65950 BZXNR
>
> with regards,
> - Nagendra.
>


