From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 09/22] gpio/omap: cleanup omap1 related macros
Date: Tue, 23 Aug 2011 18:34:47 +0530
Message-ID: <4E53A56F.3050006@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-10-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:54243 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753133Ab1HWNEy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 09:04:54 -0400
Received: by mail-yx0-f173.google.com with SMTP id 3so61055yxt.32
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 06:04:53 -0700 (PDT)
In-Reply-To: <1312455893-14922-10-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> mpuio_init() function is defined under #ifdefs. It is required only in case
> of MPUIO bank type and only when PM operations are supported by it.
> This is applicable only in case of OMAP16xx SoC's MPUIO GPIO bank type.
> For all the other cases it is a dummy function. Hence clean up the same
> and remove all the OMAP SoC specific #ifdefs.
>
> bank_is_mpuio() is defined as a check to identify if the bank type is MPUIO.
> It is not required to define it separately as zero for OMAP2PLUS. Remove this.
>
> Signed-off-by: Charulatha V<charu@ti.com>

Looks good though it can be cleaned up in the patch where
'bank_is_mpuio()' introduced.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh

