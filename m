From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/2] ARM: OMAP4: Fix NULL pointer dereference crash.
Date: Mon, 24 Aug 2009 19:59:08 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA434F93@dbde02.ent.ti.com>
References: <1250846095-6381-1-git-send-email-santosh.shilimkar@ti.com>
 <20090824141040.GH5165@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37638 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbZHXO3g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 10:29:36 -0400
In-Reply-To: <20090824141040.GH5165@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>

Kevin,
> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Monday, August 24, 2009 7:41 PM
> To: Shilimkar, Santosh
> Cc: rmk@arm.linux.org.uk; khilman@deeprootsystems.com; linux-arm-
> kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org; Syed, Rafiuddin
> Subject: Re: [PATCH 1/2] ARM: OMAP4: Fix NULL pointer dereference crash.
> 
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [090821 12:15]:
> > After the patch series "[PATCH 00/14] OMAP PM fixes for .31-rc"
> > merge in 2.6.31-rc5, the kernel crashed during boot on OMAP4430.
> > This patch fixes it by adding UART4 support and related code.
> > Without this patch omap_serial_init() would produce " NULL pointer
> > dereference" and kernel crashes in the bootup on OMAP4430 platform.
> >
> > Some more info on the merge issue can be found here.
> > More info- http://lkml.org/lkml/2009/8/20/192
> >
> > Note: While merging this patch,"IO_ADDRESS" needs to be changed
> > to "OMAP2_IO_ADDRESS" if the Tony's below series is already merged in.
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg15072.html
> >
> > Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/board-4430sdp.c |    2 +-
> >  arch/arm/mach-omap2/serial.c        |   27 ++++++++++++++++++++++++++-
> >  2 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
> omap2/board-4430sdp.c
> > index b0c7402..1b22307 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -39,7 +39,7 @@ static struct platform_device *sdp4430_devices[]
> __initdata = {
> >  };
> >
> >  static struct omap_uart_config sdp4430_uart_config __initdata = {
> > -	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2),
> > +	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
> >  };
> >
> 
> This part above won't be needed any longer with patches in omap for next.

Will you fix this in your branch or shall I post v4.

Regards
Santosh
 
