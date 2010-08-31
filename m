From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP: McBSP: Do not enable SRG in slave mode
Date: Tue, 31 Aug 2010 13:36:14 +0300
Message-ID: <20100831133614.a7d0c031.jhnikula@gmail.com>
References: <1283242304-27738-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40940 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab0HaKfG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 06:35:06 -0400
Received: by ewy23 with SMTP id 23so3615537ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Aug 2010 03:35:05 -0700 (PDT)
In-Reply-To: <1283242304-27738-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Tue, 31 Aug 2010 11:11:44 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> McBSP SRG (Sample Rate Generator) and FSG (Frame Sync
> Generator) is only needed to be enabled, when McBSP
> is master.
> In McBSP slave mode, the SRG, and FSG can be kept disabled,
> which might save some power at the end in this configuration.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
> 
> Hello Jarkko,
> 
> I have tested this on OMAP3, but I think this should be
> applicable for other OMAP versions as well.
> When McBSP was slave the audio worked fine, when I left
> the SRG, and FSG disabled.
> 
Sounds logical if there is no need to keep SRG and FSG active when
McBSP is slave. I tested this on N810.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
