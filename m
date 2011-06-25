From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Sat, 25 Jun 2011 16:49:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106251647110.30205@utopia.booyaka.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55146 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab1FYWt0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jun 2011 18:49:26 -0400
In-Reply-To: <1308932625-17632-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 24 Jun 2011, Sanjeev Premi wrote:

> The current selection of the GPTIMER on was result of
> a hardware issue in early versions of the Beagleboards
> (Ax and B1 thru B4). [1] [2]
> 
> Its been long since the hardware issue has been fixed.
> This patch uses GPTIMER 1 for all newer board revisions
> incl. Beagleboard XM.
> 
>  [1] http://thread.gmane.org/gmane.comp.hardware.beagleboard.general/91
>  [2] Errata #7 at http://elinux.org/BeagleBoard#Errata
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

>   * Browsing through the code, it appears that similar
>     change could be applied for these boards:
>      - devkit8000
>      - omap3stalker
>      - omap3touchbook
>     However, I don't have access to any of these;
>     or information on their revisions.
>     I can update this patch based on confirmations.

You might want to send an E-mail to the people who are listed as authors 
in git for these boards.  Otherwise they will probably miss it in the 
onslaught of mailing list traffic.  Unless the PCB designs are based on 
A or B revisions of the BeagleBoard, it should be safe for them to switch 
to GPTIMER1.


- Paul
