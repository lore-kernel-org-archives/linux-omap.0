From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RESEND 2][Review Request] Adding csi2_fck declaration to
 clock34xx.h
Date: Wed, 3 Sep 2008 09:22:57 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809030921570.13646@utopia.booyaka.com>
References: <A24693684029E5489D1D202277BE894411A07844@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57300 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbYICPW7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 11:22:59 -0400
In-Reply-To: <A24693684029E5489D1D202277BE894411A07844@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, saaguirre@ti.com

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
