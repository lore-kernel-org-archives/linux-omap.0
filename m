From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 08/16] OMAP2+: UART: Store certain reg values to port structure
Date: Mon, 10 Oct 2011 16:58:46 -0700
Message-ID: <8739f0bdqh.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-8-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39375 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061Ab1JJX6u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 19:58:50 -0400
In-Reply-To: <1317380495-584-8-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:31:34 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> In preparation to runtime conversion add missing uart regs to
> port structure which can be used in context restore.
> Also ensuring all uart reg info's are part of port structure.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

IMO, this should come later in the series to avoid adding bunch of code
that gets moved in a subsequent patch.

First, convert to runtime PM (current patch 9/16)
Then, add a patch to move context save/restore into driver.
Then, add this patch.

Kevin
