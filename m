From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/8] OMAP2+: hwmod framework fixes
Date: Wed, 6 Jul 2011 15:33:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107061532390.31498@utopia.booyaka.com>
References: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38056 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab1GFVdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 17:33:17 -0400
In-Reply-To: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> Here are the latest bug fixes done on the hwmod framework.
> There are mainly around wakeup capability added in OMAP4.
> 
> The series is based on for_3.1/2_prcm_files_cleanup and tested
> on OMAP4430 ES2.1 + SDP.
> 
> The patches are available here:
> git://gitorious.org/omap-pm/linux.git for_3.1/3_hwmod_fixes

Thanks, this series has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'hwmod_core_cleanup_a_3.1' branch.


- Paul
