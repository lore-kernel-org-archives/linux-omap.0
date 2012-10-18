From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Fri, 19 Oct 2012 02:18:29 +0530
Message-ID: <50806B1D.9040504@ti.com>
References: <20121017181354.GA2412@netboy.at.omicron.at> <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com> <20121017235045.GB30550@atomide.com> <20121018030654.GE2867@netboy.at.omicron.at> <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com> <20121018184443.GD2350@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57294 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab2JRUsk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 16:48:40 -0400
In-Reply-To: <20121018184443.GD2350@netboy.at.omicron.at>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 10/19/2012 12:14 AM, Richard Cochran wrote:
> On Thu, Oct 18, 2012 at 03:46:15AM +0000, Paul Walmsley wrote:
>>
>> Probably the driver was submitted before any SoC integration support was 
>> available.  Grepping for 'cpsw' under arch/ turns up only AM33xx.  AM335x 
>> didn't have device enumeration support in the mainline kernel until 3.7, 
>> via commit a2cfc509bc4eeef9f5c4607b1203f17f22ea2a36 ("ARM: OMAP3+: hwmod: 
>> Add AM33XX HWMOD data").  So I don't see how it could have worked with 
>> mainline.
> 
> ...
> 
>> But it seems that the CPSW has never worked in the mainline kernel.  So 
>> this particular patch is not fixing a regression.  Therefore we shouldn't 
>> send it upstream during the -rc time period.  Instead we'll schedule it to 
>> be sent a few weeks later, during the 3.8 merge window.
> 
> Let's think about this some more:
> 
> The driver's commit is from March and is included in v3.4-rc1.
> 
> You say it will be working in 3.8, after 3.7 comes out, in about
> December.
> 
> So how long does it take between merging code and actually getting it
> working?
> 
> Sorry to harp on this so much, but I try out my patches with the tip
> of the appropriate tree before sending them, or when I cannot, at
> least I put into the log "compile tested only" or something like that.
> 

Another important point is, this driver is also required and used for
Davinci family of devices (arch/mach/mach-davinci/).

Thanks,
Vaibhav

> Thanks,
> Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
