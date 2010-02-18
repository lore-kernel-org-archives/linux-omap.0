From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/9] omap4 updates for 2.6.34
Date: Thu, 18 Feb 2010 10:36:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002181035240.24812@utopia.booyaka.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C417F61A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33862 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583Ab0BRRgP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 12:36:15 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C417F61A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Santosh,

On Thu, 18 Feb 2010, Shilimkar, Santosh wrote:

> This series have few omap4 updates and is based on Tony's 
> 'omap-for-linus' branch. This series patches are part of the
> below series posted on linux-omap for review earlier this week.
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg23939.html
> 
> >From the previous series, I have dropped all the clock and i2c patches
> because of few dependencies. The auto-generated dma and irq headers are
> included as per comments.
> 
> The series is boot tested on omap4430 and omap4430 sdp's with multi-omap
> and regular defconfig builds.

Aside from the two minor comments just sent, the rest of the patches are

Reviewed-by: Paul Walmsley <paul@pwsan.com>

- Paul
