From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: RE: [patch twl] twl4030-core -- more cleanups
Date: Fri, 3 Oct 2008 10:57:26 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028C5400D3@dbde02.ent.ti.com>
References: <200810021221.20286.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58588 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbYJCF1j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 01:27:39 -0400
In-Reply-To: <200810021221.20286.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>  /*
> - * twl4030_irq_thread() runs as a kernel thread.  It queries the twl4030
> - * interrupt controller to see which modules are generating interrupt requests
> - * and then calls the desc->handle method for each module requesting service.
> + * This thread processes interrupts reported by the Primary Interrupt Handler.
>   */

Why do we need to remove that piece of comment?

Can we not keep the comment this way?

  /*
 - * twl4030_irq_thread() runs as a kernel thread.  It queries the twl4030
 - * interrupt controller to see which modules are generating interrupt requests
 + * This thread processes interrupts reported by the Primary Interrupt Handler,
   * and then calls the desc->handle method for each module requesting service.
>   */

--
Jagadeesh
