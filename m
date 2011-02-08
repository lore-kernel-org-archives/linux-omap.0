From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/9] omap4: prcm: Fix the CPUx clockdomain offsets
Date: Mon, 7 Feb 2011 21:55:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102072155280.21991@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com> <1296813544-25170-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44081 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab1BHEzl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 23:55:41 -0500
In-Reply-To: <1296813544-25170-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> CPU0 and CPU1 clockdomain is at the offset of 0x18 from the LPRM base.
> The header file has set it wrongly to 0x0. Offset 0x0 is for CPUx power
> domain control register
> 
> Fix the same.
> 
> The autogen scripts is fixed thanks to Benoit Cousson
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

Thanks, queued for 2.6.39.


- Paul
