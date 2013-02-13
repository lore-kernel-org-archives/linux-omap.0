From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC 1/1] ARM: omap2: gpmc: Move binding documentation to memory-controller
Date: Wed, 13 Feb 2013 09:13:27 -0600
Message-ID: <511BAD97.5050602@ti.com>
References: <1360754003-3988-1-git-send-email-ezequiel.garcia@free-electrons.com> <1360754003-3988-2-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59097 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934031Ab3BMPNm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 10:13:42 -0500
In-Reply-To: <1360754003-3988-2-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, device-tree <devicetree-discuss@lists.ozlabs.org>


On 02/13/2013 05:13 AM, Ezequiel Garcia wrote:
> GPMC stands for General Purpose Memory Controller, and it's primarily
> used to handle memories such as NOR, NAND, SRAM.
> Note that this controller is also used to handle network controllers
> such as smsc911x.
> 
> This patch moves the documentation binding to memory-controllers,
> where it belongs.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../ti-gpmc.txt => memory-controllers/ti/gpmc.txt} |    0
>  1 files changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{bus/ti-gpmc.txt => memory-controllers/ti/gpmc.txt} (100%)
> 
> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/memory-controllers/ti/gpmc.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/bus/ti-gpmc.txt
> rename to Documentation/devicetree/bindings/memory-controllers/ti/gpmc.txt

I am fine with that. However, make sure you CC the device-tree mailing list.

Cheers
Jon

