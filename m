From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 06/14] ARM: OMAP2+: gpmc: CS configuration helper
Date: Tue, 12 Jun 2012 13:06:17 -0500
Message-ID: <4FD78519.2080409@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <9dd458171d6a68ea4f97a4ba19dbacc0d6b5ba35.1339419492.git.afzal@ti.com> <4FD66666.8060002@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997F1F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47547 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab2FLSGV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 14:06:21 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E997F1F@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 06/12/2012 03:40 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Tue, Jun 12, 2012 at 03:13:02, Hunter, Jon wrote:
> 
>>> +static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
>>> +{
>>> +	u32 l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
>>
>> Why is it necessary to read the register first? I thought you wanted to
>> get away from relying on bootloader settings?
> 
> This is not trying to depend on bootloader, it is to alter bits
> that are only meant for configuration. There are other bits in 
> the same register configured as part of time setting.

Well it is unclear what the code flow is for using this helper as this
change simply adds the helper. If someone other function is writing to
the CONFIG1 register before this function, then you may wish to
highlight the programming sequence in the changelog or at least describe
why this function performs a read-modify-write and not just a write.

Jon
