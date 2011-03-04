From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2 compatibility
 fixes
Date: Fri, 4 Mar 2011 16:55:14 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1103041654150.27995@xanadu.home>
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org> <AANLkTimz0Ko9GFtLTcBQVV_c2DAPU5XhV47xT+R9Q7mv@mail.gmail.com> <7b1ef0e49e8b8c1c20b0965a58c4fe73@mail.gmail.com> <20110304174709.GB20560@atomide.com> <AANLkTi=UCk5thBSM_JpFPRAr_POtx-DphP-DrVLBNyMG@mail.gmail.com>
 <87r5amftpx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45710 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445Ab1CDVzR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 16:55:17 -0500
Received: by qyg14 with SMTP id 14so2362608qyg.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 13:55:15 -0800 (PST)
In-Reply-To: <87r5amftpx.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

On Fri, 4 Mar 2011, Kevin Hilman wrote:

> Dave, just to confirm something The outstanding toolchain bugs only
> affect compiling in Thumb-2 mode, right?  IOW, if I merge just this
> series (without having the other toolchain workaround patches) we should
> still be able to compile/run fine in ARM mode, correct?

Correct.


Nicolas
