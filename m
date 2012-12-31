From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: hwmod: add support for blocking WFI
 when a device is active
Date: Mon, 31 Dec 2012 13:55:54 +0530
Message-ID: <50E14C12.5020105@ti.com>
References: <20121230182745.30526.47072.stgit@dusk.lan> <20121230182829.30526.32914.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49153 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab2LaIZG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Dec 2012 03:25:06 -0500
In-Reply-To: <20121230182829.30526.32914.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul,

On Sunday 30 December 2012 11:58 PM, Paul Walmsley wrote:
> Apparently, on some OMAPs, the MPU can't be allowed to enter WFI while
> certain peripherals are active.  It's not clear why, and it's likely
> that there is simply some other bug in the driver or integration code.
> But since the likelihood that anyone will have the time to track these
> problems down in the future seems quite small, we'll provide a
> flag, HWMOD_BLOCK_WFI, to mark these issues in the hwmod data.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
This is more of question. If the limitation is w.r.t MPU power
state then shouldn't we just prevent the MPU power state rather
than blocking the WFI completely.

Can you please clarify if retaining MPU power state in ON can achieve
the same results ?

Regards
Santosh


