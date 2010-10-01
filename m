From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Fri, 1 Oct 2010 10:00:10 +0300
Message-ID: <20101001100010.830d41e6.jhnikula@gmail.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com>
	<1285915146-18511-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62230 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0JAHAN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 03:00:13 -0400
Received: by ewy23 with SMTP id 23so1152479ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 00:00:12 -0700 (PDT)
In-Reply-To: <1285915146-18511-3-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri,  1 Oct 2010 09:39:06 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Implement the suggested workaround for OMAP3 regarding to sDMA draining
> issue, when the channel is disabled on the fly.
> This errata affects the following configuration:
> sDMA transfer is source synchronized
> Buffering is enabled
> SmartStandby is selected.
> 
> The issue can be easily reproduced by creating overrun situation while
> recording audio.
> Either introduce load to the CPU:
> nice -19 arecord -D hw:0 -M -B 10000 -F 5000 -f dat > /dev/null & \
> dd if=/dev/urandom of=/dev/null
> 
> or suspending the arecord, and resuming it:
> arecord -D hw:0 -M -B 10000 -F 5000 -f dat > /dev/null
> CTRL+Z; fg; CTRL+Z; fg; ...
> 
> In case of overrun audio stops DMA, and restarts it (without reseting
> the sDMA channel). When we hit this errata in stop case (sDMA drain did
> not complete), at the coming start the sDMA will not going to be
> operational (it is still draining).
> This leads to DMA stall condition.
> On OMAP3 we can recover with sDMA channel reset, it has been observed
> that by introducing unrelated sDMA activity might also help (reading
> from MMC for example).
> 
> The same errata exists for OMAP2, where the suggestion is to disable the
> buffering to avoid this type of error.
> On OMAP3 the suggestion is to set sDMA to NoStandby before disabling
> the channel, and wait for the drain to finish, than configure sDMA to
> SmartStandby again.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
