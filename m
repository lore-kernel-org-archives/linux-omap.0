From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/5] OMAP: DSS2: Miscellaneous DISPC Patches
Date: Fri, 05 Aug 2011 16:46:09 +0300
Message-ID: <1312551969.1907.84.camel@deskari>
References: <1312551364-4828-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:48568 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756700Ab1HENqO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 09:46:14 -0400
Received: by mail-ey0-f176.google.com with SMTP id 10so1946246eyz.35
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 06:46:12 -0700 (PDT)
In-Reply-To: <1312551364-4828-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-08-05 at 19:05 +0530, Archit Taneja wrote:
> Reduce the size of the large functions dispc_dump_regs(), dispc_save_context()
> and dispc_restore_context() and _dispc_setup_color_conv_coef().
> 
> Make fifo_size array length in dispc.c generic.
> 
> Applies over master branch of:
> 
> git://gitorious.org/linux-omap-dss2/linux.git
> 
> changes in v2:
> - Remove "OMAP4: DSS2: VIDEO3 pipeline support", replace it with a patch which
> makes fifo_size array length in dispc.c generic. VIDEO3 is removed because it
> has some functional dependencies with Zorder. So they should be posted together.
> 
> Archit Taneja (5):
>   OMAP: DSS2: DISPC: Prepare dispc_dump_regs() for shortening
>   OMAP: DSS2: DISPC: Shorten dispc_dump_regs()
>   OMAP: DSS2: DISPC: dispc_save_context() and dispc_restore_context()
>     cleanup
>   OMAP: DSS2: DISPC: Shorten _dispc_set_color_conv_coef()
>   OMAP: DSS2: Use a macro to declare size of the fifo_size array in
>     dispc.c
> 
>  drivers/video/omap2/dss/dispc.c |  788 +++++++++++++--------------------------
>  1 files changed, 265 insertions(+), 523 deletions(-)

Looks good, thanks.

 Tomi



