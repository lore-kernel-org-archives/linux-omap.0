From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] OMAP: omap_device: add omap_device_is_valid()
Date: Sun, 21 Feb 2010 01:35:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002210131210.24812@utopia.booyaka.com>
References: <1264532444-22706-1-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.1001271727450.1248@utopia.booyaka.com> <87ljfirvu2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44612 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab0BUIfs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Feb 2010 03:35:48 -0500
In-Reply-To: <87ljfirvu2.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On Thu, 28 Jan 2010, Kevin Hilman wrote:

> Hmm, not sure I follow...  
> 
> struct omap_device already contains a struct platform_device, which in
> turn contains a struct device, so to get an omap_device from a struct
> device, there are two container of operaions: to_platform_device() and
> to_omap_device()
> 
> 
> from omap_device.h:
> 
> struct omap_device {
> 	u32                             magic;
> 	struct platform_device		pdev;
>         [...]
> }
> #define to_omap_device(x) container_of((x), struct omap_device, pdev)
> 
> from platform_device.h:
> struct platform_device {
> 	const char	* name;
> 	int		id;
> 	struct device	dev;
>         [...]
> }
> #define to_platform_device(x) container_of((x), struct platform_device, dev)

Sorry - my E-mail was too hasty and unclear.  What I had in mind was the 
lifecycle aspect of omap_device - i.e., ensuring that omap_devices are 
automatically freed by the device core, similar to the way that 
platform_device_alloc() does it.


- Paul
