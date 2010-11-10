From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/6] omap:clocks44x-add dummy clock for mailbox
Date: Wed, 10 Nov 2010 16:27:39 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011101626570.28301@utopia.booyaka.com>
References: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com> <1289393121-7911-7-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48319 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab0KJX1k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 18:27:40 -0500
In-Reply-To: <1289393121-7911-7-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hello Hari

On Wed, 10 Nov 2010, Hari Kanigeri wrote:

> In omap4, there is no explicit configuration register to enable mailbox clocks.
> Defining dummy clock for mailbox clock module to keep the mailbox driver
> backward compatible with previous omaps.

If you split this off from the rest of your series, I'll queue it for .38.


- Paul
