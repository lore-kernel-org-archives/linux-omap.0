From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 1/4] Revert "arm/dts: Add support for TI AM335x EVM board"
Date: Mon, 2 Jul 2012 14:14:45 +0530
Message-ID: <4FF15F7D.1090108@ti.com>
References: <1340358050-29560-1-git-send-email-anilkumar@ti.com> <1340358050-29560-2-git-send-email-anilkumar@ti.com> <20120702084021.GF1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46442 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab2GBIpU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 04:45:20 -0400
In-Reply-To: <20120702084021.GF1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: AnilKumar Ch <anilkumar@ti.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org



On 7/2/2012 2:10 PM, Tony Lindgren wrote:
> * AnilKumar Ch <anilkumar@ti.com> [120622 02:45]:
>> This reverts commit 6c54bbb42678c99685c8e7fd09267e1cb8c2ae40.
> 
> As that has not been merged yet, I'll just drop it and set up
> a new devel-dt branch. Applying the reset into devel-dt.
> 

Yeah, that's better.

Care to include it into you next pull request.

Thanks,
Vaibhav
