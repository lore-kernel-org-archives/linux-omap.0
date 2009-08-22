From: Graeme Gregory <dp@xora.org.uk>
Subject: Re: [PATCH 0/5] Cleanup DEBUG_LL infrastructure
Date: Sat, 22 Aug 2009 13:35:54 +0100
Message-ID: <4A8FE62A.8020801@xora.org.uk>
References: <1250877309-10220-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:4298 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZHVMfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Aug 2009 08:35:55 -0400
Received: by ey-out-2122.google.com with SMTP id 22so340072eye.37
        for <linux-omap@vger.kernel.org>; Sat, 22 Aug 2009 05:35:56 -0700 (PDT)
In-Reply-To: <1250877309-10220-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Vikram Pandita wrote:
> Patch1/2: clean up the DEBUG_LL infrastructure.
> Patch3: add DEBUG_LL support for Zoom2 board
> Patch4/5: some Zoom2 fixes
>
> Vikram Pandita (5):
>   OMAP1/2/3/4: DEBUG_LL: cleanup
>   OMAP1/2/3/4: Adapt board files for cleand DEBUG_LL interface
>   OMAP: Zoom2: Add DEBUG_LL interface using external Quart
>   OMAP: Zoom2: Fix serial break
>   OMAP: Zoom2: Release Dbg board detect gpio
>
>  
Thanks for this patch series, makes my zoom2 bootable again.

Graeme

