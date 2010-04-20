From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/4] OMAP2+ PRCM: standardize PRCM macros
Date: Tue, 20 Apr 2010 16:29:20 -0700
Message-ID: <87r5m9bt4f.fsf@deeprootsystems.com>
References: <20100420074204.3015.56304.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45372 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab0DTX3X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 19:29:23 -0400
Received: by pwj9 with SMTP id 9so4717345pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Apr 2010 16:29:23 -0700 (PDT)
In-Reply-To: <20100420074204.3015.56304.stgit@localhost.localdomain> (Paul Walmsley's message of "Tue\, 20 Apr 2010 01\:45\:44 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> This series standardizes the OMAP2+ PRCM register macro names to end
> in _SHIFT for bitshift counts and _MASK for bitmasks.  This is already the
> case for many of the macros, but others were unconverted; this series finally
> fixes those and their users in mainline.
>
> These patches will cause Kevin some merge pain, which is regrettable,
> but there seems to be no good time to do this sort of thing.

Merge pain accepted, this is a good cleanup.

That's the price I pay for having out of tree branches.

Kevin
