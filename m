From: kishon <kishon@ti.com>
Subject: Re: [PATCH] ARM: OMAP: RX-51: add missing USB phy binding
Date: Wed, 6 Mar 2013 14:40:57 +0530
Message-ID: <51370821.5070905@ti.com>
References: <1362481780-11018-1-git-send-email-aaro.koskinen@iki.fi> <20130305113618.GB19290@arwen.pp.htv.fi> <5135DA02.8070801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53316 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710Ab3CFJLR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Mar 2013 04:11:17 -0500
In-Reply-To: <5135DA02.8070801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Tuesday 05 March 2013 05:11 PM, kishon wrote:
> On Tuesday 05 March 2013 05:06 PM, Felipe Balbi wrote:
>> On Tue, Mar 05, 2013 at 01:09:40PM +0200, Aaro Koskinen wrote:
>>> Commit 51482be9 (ARM: OMAP: USB: Add phy binding information) forgot to
>>> add phy binding for RX-51, and as a result USB does not work anymore on
>>> 3.9-rc1. Add the missing binding.
>>>
>>> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>>
>> Acked-by: Felipe Balbi <balbi@ti.com>
> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

Btw I dint add usb_bind_phy for board-am3517evm.c, board-ti8168evm.c too 
since those board files also dint have any reference to twl4030/twl6030. 
Can someone let me know what phy these platforms use or provide a patch 
for the same?

Thanks
Kishon
