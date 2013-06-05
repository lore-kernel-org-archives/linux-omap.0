From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/5] dwc3: omap: adapt dwc3 to use extcon framework
Date: Wed, 5 Jun 2013 10:19:21 +0530
Message-ID: <51AEC351.9030607@ti.com>
References: <1370276020-17446-1-git-send-email-kishon@ti.com> <51ADF867.8060300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42896 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab3FEEt6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jun 2013 00:49:58 -0400
In-Reply-To: <51ADF867.8060300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruchika Kharwar <ruchika@ti.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, rob@landley.net, gregkh@linuxfoundation.org, benoit.cousson@linaro.org, anish198519851985@gmail.com, pmeerw@pmeerw.net

Hi Ruchika,

On Tuesday 04 June 2013 07:53 PM, Ruchika Kharwar wrote:
> Kishon,
> What is the expectation when there is no palmas tied to dwc3/dwc3-omap ?

In the probe of dwc3-omap I have this check
"if (of_property_read_bool(node, "extcon"))"
So If dwc3 node does not have extcon property, it wont try to get extcon 
device at all.

You can refer this patch to see how its handled
usb: dwc3: use extcon fwrk to receive connect/disconnect.

Thanks
Kishon
