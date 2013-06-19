From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] musb: musb: dsps: support multiple instances
Date: Wed, 19 Jun 2013 19:27:22 +0200
Message-ID: <51C1E9FA.2010002@linutronix.de>
References: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de> <1371482014-5244-2-git-send-email-bigeasy@linutronix.de> <20130618082725.GG5461@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56434 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934756Ab3FSR1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 13:27:25 -0400
In-Reply-To: <20130618082725.GG5461@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On 06/18/2013 10:27 AM, Felipe Balbi wrote:
>> --- a/arch/arm/boot/dts/am33xx.dtsi +++
>> b/arch/arm/boot/dts/am33xx.dtsi @@ -341,6 +341,14 @@ port1-mode =
>> <3>; power = <250>; ti,hwmods = "usb_otg_hs"; +			phys =
>> <&nopphy0 &nopphy1>; +		}; + +		nopphy0: usbphy@0 { +
>> compatible = "usb-nop-xceiv"; +		}; +		nopphy1: usbphy@1 { +
>> compatible = "usb-nop-xceiv"; };
>> 
>> mac: ethernet@4a100000 {

Any opinion on those phy nodes? Is it likely that we need a real phy
driver here and also expose a little more information like the memory
register or reset / vcc supply?

Sebastian
