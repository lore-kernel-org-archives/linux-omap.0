From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: clock: use std _MASK suffix for CM_FCLKEN_IVA2
 defines
Date: Mon, 18 Jan 2010 11:32:44 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001181132250.3977@utopia.booyaka.com>
References: <1263839383-12275-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55971 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab0ARSco (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 13:32:44 -0500
In-Reply-To: <1263839383-12275-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Mon, 18 Jan 2010, Kevin Hilman wrote:

> Add _MASK suffix to CM_FCLKEN_IVA2 bitfieds to conform with the rest
> of the usage in cm-regbits-34xx.h of using _SHIFT and _MASK suffixes.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Thanks Kevin, queued for .33-rc fixes. 


- Paul
