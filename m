From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP: DMA: Move plat/dma hearder to platform_data/dma-omap
Date: Fri, 28 Sep 2012 20:31:18 +0530
Message-ID: <CAMQu2gw9DJSZ4QVvo83atTpnsXyegneuQ2rJKBc+5ioiwEaqaQ@mail.gmail.com>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
 <1348839609-10456-3-git-send-email-lokeshvutla@ti.com> <20120928145459.GZ4840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:58823 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758361Ab2I1PBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 11:01:40 -0400
Received: by vbbff1 with SMTP id ff1so3234830vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 08:01:39 -0700 (PDT)
In-Reply-To: <20120928145459.GZ4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 28, 2012 at 8:25 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> * Lokesh Vutla <lokeshvutla@ti.com> [120928 06:41]:
> > Move plat/dma.h header to platform_data/dma-omap.h as
> > part of the single zImage work.
>
> Hmm there's no platform data in this header, just
> exported things for drivers to use. So it should not
> be placed into platform_data.
>
> Maybe it should be #include <asm/mach/dma-omap.h> for now?
>
I wasn't sure either when the file was placed under platform-data.
I agree for now we can keep it mach layer but than means OMAP1 and
OMAP2+ DMA header and source code needs to be split. That
is not so straight forward.

With DMA engine conversion hopefully, we might get rid of the
header eventually, but for now not sure whether we should
go ahead and follow the splitting part.

Thoughts ?

Regards
Santosh
