From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 1/4] drivers: usb: phy: add a new driver for usb part
 of control module
Date: Thu, 24 Jan 2013 21:32:46 -0800
Message-ID: <510218FE.8080606@wwwdotorg.org>
References: <1359080391-5120-1-git-send-email-kishon@ti.com> <1359080391-5120-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45918 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab3AYFcs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 00:32:48 -0500
In-Reply-To: <1359080391-5120-2-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: rob.herring@calxeda.com, rob@landley.net, tony@atomide.com, balbi@ti.com, b-cousson@ti.com, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, gregkh@linuxfoundation.org, linux@arm.linux.org.uk

On 01/24/2013 06:19 PM, Kishon Vijay Abraham I wrote:
> Added a new driver for the usb part of control module. This has an API
> to power on the USB2 phy and an API to write to the mailbox depending on
> whether MUSB has to act in host mode or in device mode.
> 
> Writing to control module registers for doing the above task which was
> previously done in omap glue and in omap-usb2 phy will be removed.

> diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/usb/usb-phy.txt

This file seems to be specific to the TI USB PHYs, not all USB PHYs;
shouldn't it be renamed ti-usb-phy.txt, or even better renamed to match
the compatible value it documents, giving ti,omap-usb2.txt?

>  add the address of control module dev conf register until a driver for
>  control module is added
>  
> +Optional properties:
> + - ctrl_module : phandle of the control module used by PHY driver to power on
> +   the PHY.

DT property names generally use - not _ as the word separator.
