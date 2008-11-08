From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: BRIDGE: DSP-DMA copy failure
Date: Sat, 08 Nov 2008 21:36:02 +0200 (EET)
Message-ID: <20081108.213602.68814136.Hiroshi.DOYU@nokia.com>
References: <BC7FE67E-F469-4D08-A3DF-F8EF66709E73@maeth.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57966 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbYKHTgT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Nov 2008 14:36:19 -0500
In-Reply-To: <BC7FE67E-F469-4D08-A3DF-F8EF66709E73@maeth.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wiking@maeth.com, vpasam@ti.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, x00omar@ti.com

Hi Viktor,

According to the error code#, "0x8000803a", it implies "Invalid stream
mode" and it seems that currently only "STRMMODE_PROCCOPY" is
supported as below?

linux/drivers/dsp/bridge/rmgr/node.c:NODE_Connect():
.....
	/*
	 * Check stream mode. Default is STRMMODE_PROCCOPY.
	 */
	if (DSP_SUCCEEDED(status) && pAttrs) {
		if (pAttrs->lMode != STRMMODE_PROCCOPY)
			status = DSP_ESTRMMODE;	/* illegal stream mode */

	}
.....

So "strmcopy.out 1" and  "strmcopy.out 2" don't seem to work at
present?

Vijay, do you have any idea on the above, how to enable the other
STRMMODE_*?

	Hiroshi DOYU

From: "ext Viktor Gal" <wiking@maeth.com>
Subject: BRIDGE: DSP-DMA copy failure
Date: Sat, 8 Nov 2008 17:04:51 +0100

> Hi,
> 
> ::: i'm trying to use the strmcpy example with option 1, aka 'dsp- 
> copy', but i get the following error:
> 
> ./strmcopy.out 1 a b
> Data streaming using DSP-DMA transport.
> DSP device detected !!
> DSPProcessor_Attach succeeded.
> DSPNode_Allocate succeeded.
> DSPNode_Connect failed. Status = 0x8000803a
> DSPNode_Terminate failed: 0x8000801b
> DSPNode_Delete succeeded.
> DSPProcessor_Detach succeeded.
> 
> I've loaded the bridgedriver module with GT_str="**=01234567"  
> argument, the logs can be found here:
> http://categorizer.tmit.bme.hu/~wiking/strmcpy-dsp-dma-debug.txt
> 
> ::: when i try to use 'proc-copy' option the strmcpy just works fine.
> 
> ::: i was using using the http://4869037.web.fc2.com/tidspbridge-20081021.tgz 
>   patch-set, but as far as i can see, there's really not much  
> difference to the tidspbridge-20081107.tgz patch-set that was released  
> yesterday.
> 
> any ideas?
> 
> regards,
> viktor
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
