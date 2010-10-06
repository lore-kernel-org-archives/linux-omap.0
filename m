From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for 2xxx devices
Date: Wed, 6 Oct 2010 12:31:28 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CF13384@dbde02.ent.ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44719 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758330Ab0JFHBm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 03:01:42 -0400
In-Reply-To: <1286296662-7639-1-git-send-email-kishon@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Kamat, Nishant" <nskamat@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Girdwood, Liam" <x0135381@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

 

> -----Original Message-----
> From: ABRAHAM, KISHON VIJAY 
> Sent: Tuesday, October 05, 2010 10:08 PM
> To: linux-omap@vger.kernel.org
> Cc: Kamat, Nishant; Varadarajan, Charulatha; ABRAHAM, KISHON 
> VIJAY; Datta, Shubhrajyoti; Basak, Partha
> Subject: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for 
> 2xxx devices
> 

This patch series is targeted to implement mcbsp driver in
hwmod way and to make use of pm_runtime APIs.

This patch series is tested on OMAP3 & 4 and yet to be tested
on OMAP2.

There are few clarifications required so that the next patch series
can be implemented after aligning.

1. Audio layer is making use of mcbsp and it's dma base addresses and
is closely coupled with omap-mcbsp.
This can be handled either by
a. providing an API with which Audio layer can get these addresses.
(or)
b. move the plat-omap/mcbsp.c and mach-omap2/mcbsp.c to sound/soc/omap/
[1]

Option (a) would only be a workaround to handle the situation. As
audio is the only user for mcbsp, option (b) is better. If option(b)
is agreed upon, the same can be addressed on top of the mcbsp hwmod
series.

2. Sidetone feature is available only in OMAP3 (McBSP2&3) which has
different base address and sys configs compared to it's mcbsp port.
Hence the mcbsp is considered as a single device with two hwmods
for McBSP2&3 devices in OMAP3.

3. Autoidle needs to be disabled for sidetone before enabling the sidetone
feature. There was a design proposed by Kishon [2] to add an API in hwmod
to modify the autoidle bit but was not agreed upon. How do we handle this
situation where the device has to disable or enable the autoidle bit at
runtime?

[1] https://patchwork.kernel.org/patch/225582/
[2] https://patchwork.kernel.org/patch/134371/

We would resend the same patch series by including alsa mailing list
(alsa-devel@alsa-project.org)

<<snip>>