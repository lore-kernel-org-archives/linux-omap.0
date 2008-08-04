From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] i2c-omap: reduce bloat
Date: Mon, 4 Aug 2008 17:09:21 +0300
Message-ID: <20080804140913.GH8885@atomide.com>
References: <20080718013912.22295.5368.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56179 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbYHDOJ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 10:09:26 -0400
Content-Disposition: inline
In-Reply-To: <20080718013912.22295.5368.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080718 04:48]:
> Don't compile the OMAP15xx I2C ISR for non-OMAP15xx builds.  Also, mark
> init-only functions in i2c-omap as __init.
> 
> Boot-tested on OMAP3430SDP ES2.

Pushing these today.

Tony

> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> ---
> 
> size:
> 3391587  157104  107136 3655827  37c893 vmlinux.3430sdp.orig
> 3390339  157104  107136 3654579  37c3b3 vmlinux.3430sdp
> 
> 
>  drivers/i2c/busses/i2c-omap.c |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
