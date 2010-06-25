From: Graeme Gregory <dp@xora.org.uk>
Subject: Re: ZOOM2 doesn't boot on upstream kernel
Date: Fri, 25 Jun 2010 15:15:38 +0100
Message-ID: <20100625151538.755f576f@xora-desktop.xora.org.uk>
References: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030DED31F3@dbde02.ent.ti.com>
	<AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.xora.org.uk ([80.68.91.202]:56739 "EHLO
	xora.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018Ab0FYOXG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 10:23:06 -0400
In-Reply-To: <AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Neshama Parhoti <pneshama@gmail.com>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 25 Jun 2010 17:05:53 +0300
Neshama Parhoti <pneshama@gmail.com> wrote:
> > 1. console=ttyS0
> 
> are you sure ?  all TI's docs state ttyS2 (and this works for me with
> TI's BSP kernels)
> 
Its ttyS0 if the omap serial driver is compiled in. The omap driver
takes the ports instead of the 8250 driver.

Graeme
