From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/3] ARM: dts: omap3-igep0020: Add USB OTG support
Date: Mon, 07 Oct 2013 13:54:38 +0200
Message-ID: <5252A0FE.5070809@collabora.co.uk>
References: <1380931479-16142-1-git-send-email-javier.martinez@collabora.co.uk> <1380931479-16142-2-git-send-email-javier.martinez@collabora.co.uk> <52529048.1040606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40560 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab3JGLzP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 07:55:15 -0400
In-Reply-To: <52529048.1040606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org

On 10/07/2013 12:43 PM, Roger Quadros wrote:
> Javier,
> 
> On 10/05/2013 03:04 AM, Javier Martinez Canillas wrote:
>> Commit ad871c10b ("ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+ boards")
>> added USB OTG support for most OMAP boards but some OMAP3 boards
>> such as the IGEPv2 were not updated. This patch adds an USB OTG
>> device node to this board.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  arch/arm/boot/dts/omap3-igep0020.dts | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
>> index eedf0d8..903e944 100644
>> --- a/arch/arm/boot/dts/omap3-igep0020.dts
>> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
>> @@ -166,3 +166,10 @@
>>  		smsc,save-mac-address;
>>  	};
>>  };
>> +
>> +&usb_otg_hs {
>> +	interface-type = <0>;
>> +	usb-phy = <&usb2_phy>;
> 
> With the PHY generic framework in Greg's usb-next branch [1], you will also need to add
> 
> +       phys = <&usb2_phy>;
> +       phy-names = "usb2-phy";
> 
>> +	mode = <3>;
>> +	power = <50>;
>> +};
>> 
> 
> So it would be good to test with the usb-next branch.
> 
> cheers,
> -roger
> 
> [1] - git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> 

Hi Roger,

Thanks for the pointer, I'll add those properties and test using the PHY generic
framework.

Thanks a lot and best regards,
Javier

