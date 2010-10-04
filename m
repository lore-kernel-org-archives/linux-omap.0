From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/2] OMAP3 PM: sleep code clean up
Date: Mon, 4 Oct 2010 15:06:42 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE613@dbde02.ent.ti.com>
References: <1285325785-6163-1-git-send-email-vishwanath.bs@ti.com>
 <1285325785-6163-3-git-send-email-vishwanath.bs@ti.com>
 <8762xu9ac0.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC356087034B6EC6A5@dbde02.ent.ti.com>
 <20101004085640.GA2529@matterhorn.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55293 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141Ab0JDJgv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 05:36:51 -0400
In-Reply-To: <20101004085640.GA2529@matterhorn.lan>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Amit Kucheria
> Sent: Monday, October 04, 2010 2:27 PM
> To: Sripathy, Vishwanath
> Cc: Kevin Hilman; linux-omap@vger.kernel.org; linaro-dev@lists.linaro.org
> Subject: Re: [PATCH 2/2] OMAP3 PM: sleep code clean up
> 
> On 10 Oct 04, Sripathy, Vishwanath wrote:
> > Kevin,
> 
> [snip]
> 
> > >
> > > But this also makes me wonder, if we're going to clean this up, the
> bulk
> > > of it could be re-written in C, with some inline asm helpers as needed.
> > Probably yes. But as this code is specific to OMAP3, do you think it's
> > worth spending time on rewriting the entire code in C? It might be a
> > significant effort and it will not be reusable for other ARM SOCs.
> 
> The C code will be more maintainable and offer more opportunities to
> refactor across OMAP flavours - perhaps OMAP4 as well.
> 
> I'm also interested in code reuse across other SoCs. We've got to be able
> to
> shut down the ARM core using common code instead of each SoC copying buggy
> code from each other. Could you list reasons why you don't think the code
> is
> re-usable?
Trust zone implementation and it's varients
