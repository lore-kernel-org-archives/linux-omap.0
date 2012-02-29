From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv3 2/4] ARM: OMAP4: prm: fix interrupt register offsets
Date: Wed, 29 Feb 2012 09:51:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202290951460.10984@utopia.booyaka.com>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com> <1330529106-10423-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59328 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208Ab2B2Qv5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 11:51:57 -0500
In-Reply-To: <1330529106-10423-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Wed, 29 Feb 2012, Tero Kristo wrote:

> Previous code used wrong instance for the interrupt register access.
> Use the right one which is OCP_SOCKET.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, queued.


- Paul
