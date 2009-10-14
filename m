From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 1/2] ARM: OMAP3: add CompuLab CM-T35 module
Date: Wed, 14 Oct 2009 09:52:05 +0200
Message-ID: <4AD58325.60209@compulab.co.il>
References: <cover.1255449748.git.mike@compulab.co.il> <067ddfa70bce94aed929176616bab1ac449c8765.1255449748.git.mike@compulab.co.il> <20091013170841.GR12700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:32867 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757381AbZJNHwn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Oct 2009 03:52:43 -0400
In-Reply-To: <20091013170841.GR12700@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Mike Rapoport <mike@compulab.co.il> [091013 10:00]:
>> This patch adds basic support for CompuLab CM-T35 module.
>>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
> 
> <snip>
> 
>> +static struct ehci_hcd_omap_platform_data ehci_pdata = {
>> +
>> +	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
>> +	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
>> +	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
>> +
>> +	.phy_reset  = true,
>> +	.reset_gpio_port[0]  = -EINVAL,
>> +	.reset_gpio_port[1]  = -EINVAL,
>> +	.reset_gpio_port[2]  = -EINVAL
>> +};
> 
> This ehci stuff should be done in a separate patch, it's not in
> the mainline tree yet.

Ok.

> Can you please check that your patch will compile OK with the
> mainline tree?

It does with ehci stuff removed... I'm too confused with amount of OMAP trees
and branches.

> Regards,
> 
> Tony
> 

-- 
Sincerely yours,
Mike.

