From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [RESEND 2][Review Request] Adding csi2_fck declaration to
 clock34xx.h
Date: Wed, 3 Sep 2008 11:33:16 -0500
Message-ID: <A24693684029E5489D1D202277BE894411A07DAF@dlee02.ent.ti.com>
References: <alpine.DEB.1.00.0809030921570.13646@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42588 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYICQdZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 12:33:25 -0400
In-Reply-To: <alpine.DEB.1.00.0809030921570.13646@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Oh ok, I'll revert that then, no problem.

So, shall I consider everything else as accepted in the patch?

Thank you very much for your time and your comments. I appreciate it.

Regards,
Sergio

-----Original Message-----
From: Paul Walmsley [mailto:paul@pwsan.com] 
Sent: Wednesday, September 03, 2008 10:23 AM
To: Aguirre Rodriguez, Sergio Alberto
Cc: linux-omap@vger.kernel.org; Aguirre Rodriguez, Sergio Alberto
Subject: Re: [RESEND 2][Review Request] Adding csi2_fck declaration to clock34xx.h

Hello Sergio,

On Tue, 2 Sep 2008, Aguirre Rodriguez, Sergio Alberto wrote:

> From: Sergio Aguirre <saaguirre@ti.com>
> 
> ARM: OMAP: Add CSI2 clock struct for handling it with clock API.
> 
> Add CSI2 clock struct for handling it with clock API when TI PM is disabled.

> +	.clkdm		= {
> +		.name = "cam_clkdm"
> +	},

Sorry to make you resend these again, but these should indeed be on one 
line, the way you had it before, to conform with the rest of the file.


- Paul

