From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 0/3] Support for OMAP3 Zoom2 board
Date: Fri, 15 May 2009 15:34:24 -0700
Message-ID: <87ab5ec7wv.fsf@deeprootsystems.com>
References: <1242422451-21551-1-git-send-email-mlc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:27487 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbZEOWeZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 18:34:25 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1333890wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 15:34:26 -0700 (PDT)
In-Reply-To: <1242422451-21551-1-git-send-email-mlc@ti.com> (Mikkel Christensen's message of "Fri\, 15 May 2009 16\:20\:48 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mikkel Christensen <mlc@ti.com>
Cc: linux-omap@vger.kernel.org

Mikkel Christensen <mlc@ti.com> writes:

> The following patch series adds support for Zoom2 board.
> This is a new version made after comments from Kevin Hilman.
>
> An external debug board is included for console and LAN.

This version looks good to me. 

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

>
> For details refer to this site:
> http://www.logicpd.com/products/development-kits/texas-instruments-zoom%E2%84%A2-omap34x-ii-mdp
>
> Future work:
>  - SMSC911x NFS mount problem
>  - Low level debug uart need to use debug board

I assume the uncompress.h and DEBUG_LL patches for UART are coming
next as they are also required to boot.

Kevin


