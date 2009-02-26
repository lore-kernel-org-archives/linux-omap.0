From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/2] usb: musb: fix the possible panic while resuming
Date: Thu, 26 Feb 2009 12:07:37 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91C14@dbde02.ent.ti.com>
References: <4d34a0a70902252154p56733ae8g7a989112503251b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47496 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbZBZGh7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 01:37:59 -0500
In-Reply-To: <4d34a0a70902252154p56733ae8g7a989112503251b@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>, "q1.kim@samsung.com" <q1.kim@samsung.com>, Minkyu Kang <mk7.kang@samsung.com>

<snip>

> Now I know that, in addition to HSUSB_MC_NINT disabled by the previous
> patch [ARM: OMAP: Disable USB interrupt in the musb_resume()
> function], USBTLL_SWAKEUP and USBHOST_SWAKEUP can be also wake-up
> source events to PRMC module. Sorry I didn't know that time. The
> remote wake uses these two SWAKEUP. David, is my previous patch is
> still NAK?

USBTLL_SWAKEUP and  USBHOST_SWAKEUP are not for MUSB.


- Anand