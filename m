From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Tue, 12 Jun 2012 12:40:01 -0500
Message-ID: <4FD77EF1.8000600@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com> <4FD64D6D.3020401@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33052 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab2FLRkD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 13:40:03 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 06/12/2012 01:53 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Tue, Jun 12, 2012 at 01:26:29, Hunter, Jon wrote:
> 
>>> +	pdev = omap_device_build(name, -1, oh, pdata,
>>> +					sizeof(*pdata), NULL, 0, 0);
>>> +	if (IS_ERR(pdev)) {
>>> +		WARN(1, "Can't build omap_device for %s:%s.\n",
>>> +						name, oh->name);
>>> +		return PTR_ERR(pdev);
>>> +	}
>>> +
>>> +	gpmc_l3_clk = clk_get(NULL, oh->main_clk);
>>> +	if (IS_ERR(gpmc_l3_clk)) {
>>> +		pr_err("Could not get GPMC clock\n");
>>> +		return PTR_ERR(gpmc_l3_clk);
>>> +	}
>>
>> My preference would be to store gpmc_l3_clk in the pdata and pass to
>> probe via the pdata. The aim would be to remove the global gpmc_l3_clk
>> altogether.
> 
> For timing calculation by platform outside of driver, we need clk rate

Right but potentially, this could be done by the driver.

>> Also we should attempt to get the clk before calling omap_device_build
>> which is registering the driver.
> 
> omap_device_build registers only device, but I agree that clk should
> be obtained before it as driver can get probed at that point

Exactly.

Jon
