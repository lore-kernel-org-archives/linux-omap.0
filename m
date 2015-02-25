From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH][v4.0-rc] ARM: dts: dra7x-evm: beagle-x15: Fix USB Host
Date: Wed, 25 Feb 2015 11:51:19 +0200
Message-ID: <54ED9B17.4060906@ti.com>
References: <1424781427-15356-1-git-send-email-rogerq@ti.com> <20150224180303.GG11056@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60892 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbbBYJvZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 04:51:25 -0500
In-Reply-To: <20150224180303.GG11056@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, nsekhar@ti.com, nm@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

On 24/02/15 20:03, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [150224 04:40]:
>> In commit 87517d26d888 ("ARM: dts: dra7-evm: Add extcon nodes for USB")
>> we enabled Extcon USB gpio to tackle the USB ID pin and get
>> peripheral mode to work.
>>
>> But the extcon-gpio-usb driver [1] didn't make it into v4.0
>> and this makes the USB driver defer probe indefinitely breaking
>> USB Host functionality.
>>
>> As a temporary fix we remove the extcon handle from the
>> USB controller and add it back when the extcon driver
>> merges in v4.1.
> 
> Uhh OK, If there are dependencies, can you please start splitting
> your patches so the dts changes that cause issues are sent only
> after the related driver changes are in Linux next?

Sure. Will be more careful next time.

> 
> Anyways, applying into omap-for-v4.0/fixes.

Thanks.

cheers,
-roger

>  
>> [1] - https://lkml.org/lkml/2015/2/2/187

