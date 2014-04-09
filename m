From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Date: Wed, 09 Apr 2014 22:16:53 +0400
Message-ID: <53458E95.4080505@cogentembedded.com>
References: <Pine.LNX.4.44L0.1404091354560.28384-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:46232 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933411AbaDISQr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2014 14:16:47 -0400
Received: by mail-la0-f49.google.com with SMTP id mc6so1434532lab.22
        for <linux-omap@vger.kernel.org>; Wed, 09 Apr 2014 11:16:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1404091354560.28384-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Stephen Warren <swarren@wwwdotorg.org>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, Peter.Chen@freescale.com, thierry.reding@gmail.com, balbi@ti.com, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

Hello.

On 04/09/2014 09:56 PM, Alan Stern wrote:

>>> Ok, the existing field is being replaced by something? I didn't get that

>>      No, not replaced. I'm adding the support for generic PHY to the existing
>> USB PHY support. I thought that was clear from the changelog.

>>> from the patch description; I thought the new name in this patch was
>>> going to be it. In that case, a temporary name of usb_phy for the
>>> existing field, or adding the new field as gen_phy sound reasonable.

>>      OK, I'll respin the patch #2 with 'gen_phy' and remove the patch #1.

> What is the reason for all of this?  That is, can you explain the
> difference between USB PHY support and general PHY support, and why we
> need both?

    The generic PHY framework (drivers/phy/phy-core.c) supports multifunction 
"complex" PHYs (some functions of which may be related to USB). My case is a 
Renesas R-Car generation 2 PHY that can switch two USB ports between different 
USB controllers (one PCI and one non-PCI on each port); I just haven't CCed 
linux-usb on my driver submission. Though there's already drivers/phy/usb/ 
driver for that hardware, it failed to meet the expectations (dynamic setting 
of the port multiplexing depending on what USB host/gadget drivers are 
loaded), so I had to write a new driver. I guess I don't need to describe 
drivers/phy/usb/ framework in detail, do I? It only provides for 
single-function "simple" USB PHYs...

> Alan Stern

WBR, Sergei

