From: frank agius <ftagius@yahoo.com>
Subject: Re: ADC timeout on Overo
Date: Wed, 07 Jan 2009 07:17:19 -0500
Message-ID: <49649D4F.5070903@yahoo.com>
References: <gje3o3$gmr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44851 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755514AbZAGMRg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jan 2009 07:17:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LKXLr-0007Ot-Rh
	for linux-omap@vger.kernel.org; Wed, 07 Jan 2009 12:17:35 +0000
Received: from cpe-024-211-231-231.nc.res.rr.com ([24.211.231.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 07 Jan 2009 12:17:35 +0000
Received: from ftagius by cpe-024-211-231-231.nc.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 07 Jan 2009 12:17:35 +0000
In-Reply-To: <gje3o3$gmr$1@ger.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org

Frank Agius wrote:

> Further debug shows that in the module initialization 
> routine twl4030_madc_set_power, as soon as the MADC is powered on by 
> setting CTRL1[0] MADCON bit to 1, the BUSY bit of CTRL_SW1 turns on and 
> never turns off.  I'm guessing this constant state of busy is why the 
> conversion never completes. 

I'm still having the same problem with the conversion never completing, 
but my initial debug analysis was wrong.  The BUSY bit does not turn on 
when power is applied.  BUSY turns on when the conversion is started. 
The conversion never completes (BUSY never turns off). BUSY can only be 
reset with a power cycle (removing and reinserting the driver does not 
clear BUSY).

Im trying to understand if this is a driver problem or something 
specific to the Overo.  Can anyone with one of the boards that has 
support enabled for the twl4030 driver (EVM2, EVM3, LDP and 
2340/3430sdp)confirm the status of ADC on that board?  If it's 
functional, what is the Linux revision of the working driver?

regards,
frank

