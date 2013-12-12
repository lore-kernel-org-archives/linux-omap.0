From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Thu, 12 Dec 2013 01:39:14 +0100
Message-ID: <1824203.Ui6fpnZVmO@avalon>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46663 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab3LLAjC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Dec 2013 19:39:02 -0500
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

Hi Tomi,

On Wednesday 04 December 2013 14:28:27 Tomi Valkeinen wrote:
> Hi,
> 
> Here's a new version for DT support to OMAP Display Subsystem. See
> http://article.gmane.org/gmane.linux.ports.arm.omap/102689 for the intro of
> the previous version, which contains thoughts about the related problems.
> 
> The major change in this version is the use of V4L2 and CDF style
> port/endpoint style in the DT data.

That's great, and I fully support that. This also calls for refactoring the 
V4L2 DT bindings and support code to share them with display devices. A 
bikeshedding question is where to put the common code.

> However, note that even if the DT data contains proper port & endpoint data,
> the drivers only use the first endpoint. This is to simplify the patches, as
> adding full support for the ports and endpoints to the drivers will be a big
> task.

That's perfectly fine, there's no need to implement unused features just for 
the sake of it, as long as the bindings are forward-compatible in that 
respect.

> This approach still works with more or less all the boards, as the only
> cases where the simpler model is an issue are the boards with multiple
> display devices connected to a single output.
> 
> Laurent, I'd appreciate if you could have a look at the .dts changes, to see
> if there's anything that's clearly not CDF compatible.

I've quickly reviewed the patch set, concentrating on the .dts changes. 
Overall it looks good to me, but I suspect that we will need quite some time 
to finalize standard bindings as there's lots of small details that need to be 
taken care of.

The major point that bothers we, as explained in my reply to one of the 
patches, is that I feel like the multi-device model (virtual DSS core + DSS 
modules) might not accurately represent the hardware. Departing from it 
probably sounds scary but might not be such a large change.

> The patches can also be found from:
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt
> 
> A few notes:
> 
> - The DT data are added separately in the end of .dts files for clarity. In
>   the final version I will move them to appropriate places in the .dts
>   files.
> 
> - No binding documentation. I will add them for the next version, if there
>   are no major changes needed. Hopefully the bindings are quite self-
>   explanatory for people with understanding of the hardware in question.

My plan is to split the connection information from the V4L2 bindings and make 
that a separate document. If all goes well I should be able to spend Saturday 
on this.

> - The connectors' compatible strings are "ti,xxx". As there's nothing TI
>   specific there, I think I will rename them to be without "ti".

-- 
Regards,

Laurent Pinchart

