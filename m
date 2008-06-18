From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [RFC/PATCH  0/4] McBSP support  for 34XX
Date: Wed, 18 Jun 2008 14:47:10 +0530
Message-ID: <018b01c8d124$18b65710$6ff6180a@ent.ti.com>
References: <003a01c8cfab$67149ae0$318918ac@ent.ti.com> <20080618101646.b25c6fbd.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38140 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbYFRJRh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jun 2008 05:17:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

thanks for the comments
i will make the necessary changes (for your and tony's comments)  and resend 
it asap.

----- Original Message ----- 
From: "Jarkko Nikula" <jarkko.nikula@nokia.com>
To: "ext Chandra shekhar" <x0044955@ti.com>
Cc: <linux-omap@vger.kernel.org>
Sent: Wednesday, June 18, 2008 12:46 PM
Subject: Re: [RFC/PATCH 0/4] McBSP support for 34XX


>> Hi,
>>
>> Here is a patch that adds support for McBSP on 34XX.
>> It has been verified in digital loopback mode.
>>
> Hi,
>
> I tested the set with N810 ASoC audio and still plays :-)
>
> Some comments. First, commit messages should more descriptive than
> "McBSP support for 34XX" for all of them. Like:
>
> 1. Add support for OMAP34xx McBSP ports 3-4
> 2. Fix register access width for OMAP34xx (this should be -rc patch?)
> 3. ...
>
>> The patch includes the following features.
>>
>> 1. McBSP enabled in defconfig
> This should go as a separate patch since it is for 3430dsp only.
>
>> 2. Supporting all the LP features.
>> 3. Support of DMA chaining mode and one time configuration for entire
>> transfer to improve performance.
>> 4. Independent configurations and transfer of Rx and Tx
>> 5. MCBSP data transfer in 8, 16 and 32 bit mode.
>>
> I think we should have some expected use case for these before adding
> the features?
>
>> 6. instead of mcbsp client configuring all the register, it allows
>> clients to  configure parameters like clk polarity, clk src and other
>> parameters.
>>
> This would be good direction. E.g. it's bit hacky how configuration is
> now done in sound/soc/omap/omap-mcbsp.c where McBSP register cache is
> have to use because all of the registers are written in once with
> omap_mcbsp_config.
>
>
> Jarkko 

