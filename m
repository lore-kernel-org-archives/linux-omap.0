From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] of: Add a reg-names property to name reg entries
Date: Tue, 25 Oct 2011 15:40:36 +0200
Message-ID: <4EA6BC54.7030007@ti.com>
References: <1319471697-8970-1-git-send-email-b-cousson@ti.com> <20111025082632.GJ4429@atomide.com> <440786C5-FA1C-4750-9990-0BA5AABC2190@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52332 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933466Ab1JYNlf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Oct 2011 09:41:35 -0400
In-Reply-To: <440786C5-FA1C-4750-9990-0BA5AABC2190@kernel.crashing.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On 10/25/2011 12:29 PM, Segher Boessenkool wrote:
>>> +		compatible = "ti,mcasp";
>>> +		reg =<0 0x10 0x10>,<0 0x20 0x10>,
>>> +		<1 0x10 0x10>,<1 0x20 0x10>;
>>> +		reg-names = "mpu", "dat",
>>> +			    "dma", "dma_dat";
>>
>> Hmm for some systems looks like this can also solve how to pass the
>> mux signal names cleanly from DT.
>
> What problem does any of this solve?  The device binding for the
> "mcasp" device will have to describe the possible "reg-names", and
> what those mean; but the binding already has to describe its "reg"
> property anyway.

What this solve is the ability to use the platform_get_resource_byname 
directly to retrieve the proper register base address. The binding is 
just a text description that the driver will not be able to use 
directly. It will have to get the resource using an abstract index.
It thus removes a level of indirection that is error prone and useless 
most of the time.

Benoit

