From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v5, 0/3] DT support for NAND on OMAP2
Date: Thu, 20 Jun 2013 06:34:08 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9DECE7@DBDE04.ent.ti.com>
References: <1369986545-29204-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53901 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab3FTGeV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jun 2013 02:34:21 -0400
In-Reply-To: <1369986545-29204-1-git-send-email-pekon@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Philip, Avinash" <avinashphilip@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "jacmet@sunsite.dk" <jacmet@sunsite.dk>, "zonque@gmail.com" <zonque@gmail.com>, Jon Hunter <jgchunter@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi, 

In the following series, 1 got merged, while other 2 are awaiting.
Request you to please look into these.

[PATCH 1/3] ARM: dts: AM33XX: Add ELM node -- awaiting --
[PATCH 2/3a] ARM: dts: AM33XX: Add GPMC node -- accepted by Tony
[PATCH 2/3b] ARM: dts: AM33xx: Fix properties on gpmc node -- accepted by Benoit (follow-up)
[PATCH 3/3] ARM: dts: AM33XX: Add NAND flash device tree data to am335x-evm --awaiting --

with regards, pekon

> -----Original Message-----
> From: Gupta, Pekon
> Sent: Friday, May 31, 2013 1:19 PM
> To: Tony Lindgren; linux-omap@vger.kernel.org
> Cc: Gupta, Pekon; Philip, Avinash; Nori, Sekhar; Balbi, Felipe; Hiremath,
> Vaibhav; Cousson, Benoit; jacmet@sunsite.dk; zonque@gmail.com; Jon
> Hunter
> Subject: [PATCH v5, 0/3] DT support for NAND on OMAP2
> 
> From: "Gupta, Pekon" <pekon@ti.com>
> 
> Changes v4->v5
> 	- updated commit descriptions.
> 	- included patch by "Lars Poeschel" instead of [Patch 2/3]
> 
> Changes v3->v4
> 	- rebased to linux-3.10-rc3
> 	- updated newly supported DT properties based on following
> commits
> 	[d36b4cd] jon-hunter@ti.com ARM: OMAP2+: Add additional GPMC
> timing ...
> 	[8c8a777] jon-hunter@ti.com ARM: OMAP2+: Add function to read
> GPMC ...
> 	[9f83315] jon-hunter@ti.com ARM: OMAP2+: Add variable to store
> number
> 
> Changes v2->v3
> 	- rebased to linux-3.9-rc8
> 	- AM335x-evm.dts: moved GPMC pin-mux config to nand node
> 
> Changes v1->v2
> 	- Change number of chip select to 7
> 	- Replace <xx> literals to 52
> 	- remove tab
> 
> Lars Poeschel (1):
>   dts: am33xx: Correct properties on gpmc node
> 
> Philip Avinash (1):
>   ARM: dts: AM33XX: Add NAND flash device tree data to am335x-evm
> 
> Philip, Avinash (1):
>   ARM: dts: AM33XX: Add ELM node
> 
>  arch/arm/boot/dts/am335x-evm.dts | 105
> +++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/am33xx.dtsi    |  12 ++++-
>  2 files changed, 115 insertions(+), 2 deletions(-)
> 
> --
> 1.8.1

