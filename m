From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH v4 0/3] Prepare for OMAP2+ movement to Common Clk
Date: Fri, 31 Aug 2012 10:33:39 +0530
Message-ID: <504045AB.5010302@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1208302052210.29754@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53814 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab2HaFDy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 01:03:54 -0400
In-Reply-To: <alpine.DEB.2.00.1208302052210.29754@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, mturquette@ti.com



On 8/31/2012 2:26 AM, Paul Walmsley wrote:
> Hi Rajendra
> 
> On Wed, 29 Aug 2012, Rajendra Nayak wrote:
> 
>> Changes in v4:
>> * Added *hack* comments around clk_prepare usage in hwmod
>> rebased on 3.6-rc
> 
> Assuming this is so (haven't looked closely at this series yet), and after 
> the existing comments are taken into consideration and a new version 
> reposted, will queue this series for 3.7.
> 
> Care to respin your series that converts the data also, on top of your new 
> version of this series?  We should try to get that into 3.7 also.
> BTW are you still waiting for something from Vaibhav Hiremath for this?  
> Or can the scripts convert the existing clock33xx_data.c also?
> 

I believe I have already shared all the patches with Rajendra, so please
let me know if anything is pending on me.

Thanks,
Vaibhav

> 
> - Paul
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
