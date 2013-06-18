From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 4/4] ARM: OMAP2+: dts: HACK: Provide alias to USB PHY
 clock
Date: Tue, 18 Jun 2013 15:33:06 +0300
Message-ID: <51C05382.8090805@ti.com>
References: <1371553891-29364-1-git-send-email-rogerq@ti.com> <1371553891-29364-5-git-send-email-rogerq@ti.com> <20130618112342.GN5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36873 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932160Ab3FRMde (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jun 2013 08:33:34 -0400
In-Reply-To: <20130618112342.GN5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 06/18/2013 02:23 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [130618 04:17]:
>> Till the OMAP clocks are correctly defined in device tree, use
>> this temporary hack to provide clock alias to the USB PHY clocks.
>>
>> Without this, USB Host & Ethernet will not be functional with
>> device tree boots on Panda and uEVM.
> 
> Thanks, this looks OK to me to have USB working until we have the
> DT defined clock patches ready.
> 
> The $Subject needs updating though, just make it ARM: OMAP2+: and
> leave out the dts and hack from there.
> 

OK. will send v2 as i need to make another minor change in the panda dts file.

cheers,
-roger
