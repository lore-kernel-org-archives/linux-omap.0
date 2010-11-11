From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 04/13] OMAP2420: DMA: hwmod: add system DMA
Date: Thu, 11 Nov 2010 15:04:00 -0800
Message-ID: <871v6rv4wv.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-5-git-send-email-manjugk@ti.com>
	<87mxpihyzh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33064 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab0KKXEF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 18:04:05 -0500
Received: by gxk23 with SMTP id 23so1553711gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Nov 2010 15:04:04 -0800 (PST)
In-Reply-To: <87mxpihyzh.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Tue, 09 Nov 2010 15:13:38 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
>
>> Add OMAP2420 DMA hwmod structures.
>
> s/structures/data/
>
> Also, as pointed out in many other hwmod reviews, when adding hwmod
> data, subject should be something like: 
>
>       OMAP2420: hwmod_data: add system DMA
>

Oops... no underscore here please.  IOW:

        OMAP2420: hwmod data: add system DMA

Sorry for the confusion,

Kevin
