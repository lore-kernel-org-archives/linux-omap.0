From: Roger Quadros <rogerq@ti.com>
Subject: Re: dwc3 gadget fails on dra7-evm
Date: Thu, 15 Jan 2015 14:40:13 +0200
Message-ID: <54B7B52D.6080008@ti.com>
References: <54B68EC8.9000003@ti.com> <20150114165733.GC16533@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58154 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbbAOMkQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2015 07:40:16 -0500
In-Reply-To: <20150114165733.GC16533@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: George Cherian <george.cherian@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

On 14/01/15 18:57, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Jan 14, 2015 at 05:44:08PM +0200, Roger Quadros wrote:
>> In 3.19-rc4 on dra7-evm or dra72-evm
>>
>> modprobe g_zero
>> [   34.680683] zero gadget: Gadget Zero, version: Cinco de Mayo 2008
>> [   34.687074] zero gadget: zero ready
>> [   34.694133] dwc3 48890000.usb: failed to enable ep0out
>> [   34.701600] zero 48890000.usb: failed to start zero: -110
>> ERROR: could not insert 'g_zero': Connection timed out
>>
>> my u-boot version is v2015.01
> 
> hmm... it could be that DRA7x also needs the suspend phy quirk. Can you
> try this ?

The issue goes away with this patch. Thanks.

cheers,
-roger

> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 22771bc1643a..63f8b007bdc5 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1257,6 +1257,8 @@
>  				tx-fifo-resize;
>  				maximum-speed = "super-speed";
>  				dr_mode = "otg";
> +				snps,dis_u3_susphy_quirk;
> +				snps,dis_u2_susphy_quirk;
>  			};
>  		};
>  
> @@ -1278,6 +1280,8 @@
>  				tx-fifo-resize;
>  				maximum-speed = "high-speed";
>  				dr_mode = "otg";
> +				snps,dis_u3_susphy_quirk;
> +				snps,dis_u2_susphy_quirk;
>  			};
>  		};
>  
> @@ -1299,6 +1303,8 @@
>  				tx-fifo-resize;
>  				maximum-speed = "high-speed";
>  				dr_mode = "otg";
> +				snps,dis_u3_susphy_quirk;
> +				snps,dis_u2_susphy_quirk;
>  			};
>  		};
>  
> 
> Weird, I remeber testing on X15 and not needing this quirk :-s
> 

