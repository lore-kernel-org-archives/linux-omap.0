From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v9 4/4] OMAP: McBSP: Use cache when modifying individual
 register bits
Date: Fri, 15 Jan 2010 17:43:11 +0100
Message-ID: <4B509B1F.2000302@tis.icnet.pl>
References: <201001141658.32034.jkrzyszt@tis.icnet.pl> <201001141713.38660.jkrzyszt@tis.icnet.pl> <201001151111.28462.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:36118 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754445Ab0AOQnX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 11:43:23 -0500
In-Reply-To: <201001151111.28462.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Peter Ujfalusi wrote:
> Hello,

Hi Peter,

> I think there are some inconsistency in a way how for example the SPCR1 and 
> SPCR2 registers are used.
> 
> On Thursday 14 January 2010 18:13:36 ext Janusz Krzysztofik wrote:
>> Change the way McBSP registers are updated: use cached values instead of
>> relying upon those read back from the device.
>>
>> With this patch, I have finally managed to get rid of all random
>> playback/recording hangups on my OMAP1510 based Amstrad Delta hardware.
>>  Before that, values read back from McBSP registers to be used for updating
>>  them happened to be errornous.
>>
>> From the hardware side, the issue appeared to be caused by a relatively
>>  high power requirements of an external USB adapter connected to the
>>  board's printer dedicated USB port.
>>
>> I think there is one important point that makes this patch worth of
>>  applying, apart from my hardware quality. With the current code, if it
>>  ever happens to any machine, no matter if OMAP1510 or newer, to read
>>  incorrect value from a McBSP register, this wrong value will get written
>>  back without any checking. That can lead to hardware damage if, for
>>  example, an input pin is turned into output as a result.
>>
>> Applies on top of patch 3 from this series:
>> [PATCH v9 3/4] OMAP: McBSP: Introduce caching in register write operations
>>
>> Tested on OMAP1510 based Amstrad Delta using linux-omap for-next, commit
>> fb7380d70e041e4b3892f6b19dff7efb609d15a4 (2.6.33-rc3+ dated 2010-01-11).
>> Compile-tested with omap_3430sdp_defconfig.
>>
>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>>
>> ---
>> No functional changes since v3.
>>
>>  arch/arm/plat-omap/mcbsp.c |   78
>>  +++++++++++++++++++++++++++------------------ 1 file changed, 47
>>  insertions(+), 31 deletions(-)
>>
>> --- git/arch/arm/plat-omap/mcbsp.c.orig	2010-01-14 00:36:14.000000000 +0100
>> +++ git/arch/arm/plat-omap/mcbsp.c	2010-01-14 02:05:23.000000000 +0100
>> @@ -114,7 +114,8 @@ static irqreturn_t omap_mcbsp_tx_irq_han
>>  		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
>>  			irqst_spcr2);
>>  		/* Writing zero to XSYNC_ERR clears the IRQ */
>> -		MCBSP_WRITE(mcbsp_tx, SPCR2, irqst_spcr2 & ~(XSYNC_ERR));
>> +		MCBSP_WRITE(mcbsp_tx, SPCR2,
>> +			    MCBSP_READ_CACHE(mcbsp_tx, SPCR2) & ~(XSYNC_ERR));
> 
> The reg_cache will never have the XSYNC_ERR, or any other flags set, since these 
> flags has never written to the reg_cache.
> So it is kind of not necessary to clear the flag, which is actually always 0.

Agree.

> Another thing is that as far as I understand the reason behind of this series is 
> that you have a problem, that you can not trust on the values that you read from 
> the McBSP registers, if this is true, than the problem can occur when the above 
> path has been taken:
> 
> ...
> 	irqst_spcr2 = MCBSP_READ(mcbsp_tx, SPCR2);
> ...
> 	if (irqst_spcr2 & XSYNC_ERR) {
> 
> But since you read from McBSP registers much rarely, than probably the 
> corruption is not that visible?

Sure no software solution can correct my hardware issue in case of
register bits manintained by the hardware itself. Well, maybe software
that limits heat dissipation by lowering overal power consumption could
do to some extent ;).

What I'm going to address here is only a case when writing back possibly
corrupted bits can be avoided if correct values are well known and
can be determined without reading them back from the register itself.

> Anyway, clearing the status/error flags are not necessary, since the reg_cache 
> will never got these bits set, you could just write back the SPCR2/SPCR1 
> register content from the cache as it is...
> 
> 
>>  	} else {
>>  		complete(&mcbsp_tx->tx_irq_completion);
>>  	}
>> @@ -134,7 +135,8 @@ static irqreturn_t omap_mcbsp_rx_irq_han
>>  		dev_err(mcbsp_rx->dev, "RX Frame Sync Error! : 0x%x\n",
>>  			irqst_spcr1);
>>  		/* Writing zero to RSYNC_ERR clears the IRQ */
>> -		MCBSP_WRITE(mcbsp_rx, SPCR1, irqst_spcr1 & ~(RSYNC_ERR));
>> +		MCBSP_WRITE(mcbsp_rx, SPCR1,
>> +			    MCBSP_READ_CACHE(mcbsp_rx, SPCR1) & ~(RSYNC_ERR));
> 
> Same here.
> 
> ...
> 
>> @@ -653,7 +657,7 @@ int omap_mcbsp_pollwrite(unsigned int id
>>  	if (MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {
>>  		/* clear error */
>>  		MCBSP_WRITE(mcbsp, SPCR2,
>> -				MCBSP_READ(mcbsp, SPCR2) & (~XSYNC_ERR));
>> +				MCBSP_READ_CACHE(mcbsp, SPCR2) & (~XSYNC_ERR));
> 
> Well, I think here also, the reg_cache does not have the XSYNC_ERR set, it is 
> only set in the McBSP register.
> 
>>  		/* resend */
>>  		return -1;
>>  	} else {
>> @@ -662,10 +666,12 @@ int omap_mcbsp_pollwrite(unsigned int id
>>  		while (!(MCBSP_READ(mcbsp, SPCR2) & XRDY)) {
>>  			if (attemps++ > 1000) {
>>  				MCBSP_WRITE(mcbsp, SPCR2,
>> -					    MCBSP_READ(mcbsp, SPCR2) & (~XRST));
>> +						MCBSP_READ_CACHE(mcbsp, SPCR2) &
>> +						(~XRST));
> 
> Also here, the XRST will surely not set in the cached SPCR2...
> 
> This applies fro all other cases regarding to status/error bits in McBSP.

OK, I can try to identify all those cases.

What about introducing this simplification in a separate followup patch,
quoting your rationale in its changelog? I can try to prepare one if you
agree.

Thanks,
Janusz

