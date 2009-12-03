From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v3 0/4] OMAP: McBSP: Use register cache
Date: Thu, 3 Dec 2009 09:49:05 +0200
Message-ID: <20091203094905.4c4fec7b.jhnikula@gmail.com>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:40818 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbZLCHrz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 02:47:55 -0500
Received: by bwz27 with SMTP id 27so858355bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 02 Dec 2009 23:48:01 -0800 (PST)
In-Reply-To: <200912010410.10129.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tue, 1 Dec 2009 04:10:07 +0100
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> Change the way McBSP registers are maintained: store values written to the
> device in a cache in order to  make use of those cached values when
> convenient.
> 
> This could help for developing the McBSP context save/restore features, as
> well as solve the problem of possible register corruption experienced on
> OMAP1510 based Amstrad Delta board, at least.
> 
> Janusz Krzysztofik (4):
> 	OMAP: McBSP: Use macros for all register read/write operations
> 	OMAP: McBSP: Prepare register read/write macros API for caching
> 	OMAP: McBSP: Introduce caching in register write operations
> 	OMAP: McBSP: Use cache when modifying individual register bits
> 
>  arch/arm/plat-omap/include/plat/mcbsp.h |    5
>  arch/arm/plat-omap/mcbsp.c              |  397 ++++++++++++++++++++++++---------------------------
>  2 files changed, 198 insertions(+), 204 deletions(-)
> 
Looks good to me and audio works fine with the Beagle. One minor
comment to the patch 3.

-- 
Jarkko
