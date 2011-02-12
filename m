From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/7] omap: clock: Check for enable/disable ops support
Date: Sat, 12 Feb 2011 16:17:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102121615130.21991@utopia.booyaka.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com> <1297159838-30282-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53231 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab1BLXRt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 18:17:49 -0500
In-Reply-To: <1297159838-30282-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, 8 Feb 2011, Rajendra Nayak wrote:

> Check if enable/disable operations are supported for a given
> clock node before attempting to call them.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued in branch 'clk_a_2.6.39' of git://git.pwsan.com/linux-2.6.  

This patch is integrated as part of the tag 
'tmp-integration-2.6.39-20110212-003' and the branch 'integration-2.6.39' 
of git://git.pwsan.com/linux-integration.


- Paul
