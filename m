From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] ARM: OMAP: Remove calls to SRAM allocations for
 framebuffer
Date: Wed, 05 Oct 2011 09:45:28 +0300
Message-ID: <1317797128.2631.2.camel@deskari>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	 <20111005004544.26980.35612.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:37191 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933776Ab1JEGpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 02:45:33 -0400
Received: by mail-bw0-f43.google.com with SMTP id s6so1993396bka.2
        for <linux-omap@vger.kernel.org>; Tue, 04 Oct 2011 23:45:32 -0700 (PDT)
In-Reply-To: <20111005004544.26980.35612.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, 2011-10-04 at 17:45 -0700, Tony Lindgren wrote:
> This assumes fixed mappings which will not work once we move
> to use ioremap_exec(). It seems that these are currently
> not in use, or in use for some out of tree corner cases.
> 
> If SRAM support for framebuffer is wanted, it should be done
> with ioremap in the driver.
> 
> Note that further removal of the code can now be done,
> but that can be done seprately by the driver maintainers.
> 
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Looks good to me. I have similar changes in my working branch for omapfb
cleanup.

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


