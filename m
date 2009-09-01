From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH v2][RFC] OMAP4: sDMA driver: descriptor autoloading feature
Date: Tue, 1 Sep 2009 15:17:47 +0530
Message-ID: <04ab01ca2ae9$445220a0$LocalHost@wipultra793>
References: <0680EC522D0CC943BC586913CF3768C0037CE47C07@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45954 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202AbZIAJsA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Sep 2009 05:48:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

----- Original Message ----- 
From: "S, Venkatraman" <svenkatr@ti.com>
To: <linux-omap@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>; "Shilimkar, Santosh" 
<santosh.shilimkar@ti.com>
Sent: Thursday, August 27, 2009 4:41 PM
Subject: [PATCH v2][RFC] OMAP4: sDMA driver: descriptor autoloading feature


> (Updated version of previous patch: 
> http://marc.info/?l=linux-omap&m=125012097403050&w=2)
> Add sDMA driver support for descriptor autoloading feature.
> Descriptor autoloading is OMAP4 sDMA hardware capability that can be 
> exploited for scatter gather scenarios.
>
> The feature works as described below
> 1) A sDMA channel is programmed to be in 'linked list' mode
> 2) The client (sDMA user) provides a list of descriptors in a linked list 
> format
> 3) Each of the 'descriptor' (element in the linked list) contains an 
> updated set of DMA configuration register values
> 4) Client starts DMA transfer
> 5) sDMA controller loads the first element to its register configuration 
> memory and executes the transfer
> 6) After completion, loads the next element (in linked list) to 
> configuration memory and executes the transfer, without MCU intervention.
> 7) Interrupt is generated after all transfers are completed; this can be 
> configured to be done differently.
>
> Configurations and additional features
> 1) Fast mode & non-fast mode
>       Fast mode/non-fast decides on how the first transfer begins. In 
> non-fast mode, the first element in the linked list is loaded only after 
> completing the transfer according to the configurations already in the 
> sDMA channel registers. In fast mode, the loading of the first element 
> precedes the transfer.
>
> 2) Pause / resume of transfers
>       A transfer can be paused after a descriptor set has been loaded, 
> provided the 'pause bit' is set in the linked list element.
> An ongoing transfer cannot be paused. If the 'pause bit' is set, transfer 
> is not started after loading the register set from memory.
> Such a transfer can be resumed later.
>
> 3) Descriptor types
>       3 possible configurations of descriptors (initialized as linked list 
> elements) are possible. Type 1 provides the maximum flexibility, which 
> contains most register definitions of a DMA logical channel. Fewer options 
> are present in type 2. Type 3 can just modify source/destinations address 
> of transfers. In all transfers, unmodified registers settings are 
> maintained for the next transfer.
>
> Patch provides options / API for
> 1) Setting up a descriptor loading for DMA channel for sg type transfers
> 2) configuration with linked list elements
> 3) Starting / pause and resume of the said transfers, query state
> 4) Closing/Releasing the DMA channel
>
> The patches are generated against kernel 2.6.31-rc1, tested on OMAP4 
> simulator platform.

It might be easier to understand the APIs if you could provide an example. 
Could you take example of a contiguous/non-contiguous buffer and explain how 
the desciptor based DMA could be used on this. 

