From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] ARM : OMAP : Add empty function in header file
Date: Fri, 01 Jan 2010 01:58:15 +0200
Message-ID: <1262303895.17250.26.camel@gandalf>
References: <1262265214-16906-1-git-send-email-x0082077@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50066 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbZLaX6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Dec 2009 18:58:25 -0500
In-Reply-To: <1262265214-16906-1-git-send-email-x0082077@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maulik Mankad <x0082077@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Olof Johansson <olof@lixom.net>

Hi,

On Thu, 2009-12-31 at 18:43 +0530, Maulik Mankad wrote: 
> +#if defined(CONFIG_USB) || defined(CONFIG_USB_GADGET)

how about using CONFIG_USB_NOP_XCEIV

-- 
balbi

