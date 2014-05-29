From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 3/5] char: ti-usim: Add driver for USIM module on
 AM43xx
Date: Thu, 29 May 2014 08:53:49 -0700
Message-ID: <20140529155349.GD32214@kroah.com>
References: <1401267437-22489-1-git-send-email-satish.patel@ti.com>
 <1401267437-22489-4-git-send-email-satish.patel@ti.com>
 <CAL_JsqKs=a8GRJRmNE-oxU4imHqnb5szv+Km-wv3KuN0d6Bxkg@mail.gmail.com>
 <53870671.6080601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39593 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757422AbaE2PuM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2014 11:50:12 -0400
Content-Disposition: inline
In-Reply-To: <53870671.6080601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Satish Patel <satish.patel@ti.com>
Cc: Rob Herring <robherring2@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Landley <rob@landley.net>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>

On Thu, May 29, 2014 at 03:35:37PM +0530, Satish Patel wrote:
> >>+enum usim_card_mode {
> >>+       USIM_CARD_MODE_ASYNC = 0,       /* asynchronous mode */
> >>+       USIM_CARD_MODE_SYNC_TYPE1,      /* synchronous mode: Type 1 */
> >>+       USIM_CARD_MODE_SYNC_TYPE2,      /* synchronous mode: Type 2 */
> >>+       USIM_CARD_MODE_SYNC_OTHER,      /* Any other synchronous type */
> >>+};
> >>+struct usim_data {
> >>+       int slot;
> >>+       int rxexplen;
> >>+       int txlen;
> >>+       unsigned char apdu[256];
> >>+};

You need to use the proper variable types for a structure that is going
to cross the user/kernel boundry in an ioctl :(

