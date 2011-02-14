From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Remove pr_errs' stating unsupported
 wkdep
Date: Mon, 14 Feb 2011 09:46:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102140938070.21991@utopia.booyaka.com>
References: <1297685165-25489-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50543 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab1BNQq1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 11:46:27 -0500
In-Reply-To: <1297685165-25489-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 14 Feb 2011, Rajendra Nayak wrote:

> Now that wkup and sleep dependencies are supported (in the
> form of static deps) for OMAP4, remove all instances of
> pr_errs' stating dependencies are still unsupported
> on OMAP4.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued for 2.6.39 in the 'clkdm_statdep_omap4_2.6.39' branch of 
git://git.pwsan.com/linux-2.6.

This patch is part of the 'integration-2.6.39' branch of 
git://git.pwsan.com/linux-integration as of tag 
'integration-2.6.39-20110214-003'.


- Paul
