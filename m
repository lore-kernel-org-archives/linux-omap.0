From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: hwmod: add support for blocking WFI
 when a device is active
Date: Mon, 31 Dec 2012 12:56:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212311254570.27120@utopia.booyaka.com>
References: <20121230182745.30526.47072.stgit@dusk.lan> <20121230182829.30526.32914.stgit@dusk.lan> <50E14C12.5020105@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38978 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab2LaM4E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Dec 2012 07:56:04 -0500
In-Reply-To: <50E14C12.5020105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Mon, 31 Dec 2012, Santosh Shilimkar wrote:

> This is more of question. If the limitation is w.r.t MPU power
> state then shouldn't we just prevent the MPU power state rather
> than blocking the WFI completely.
> 
> Can you please clarify if retaining MPU power state in ON can achieve
> the same results ?

In these cases, it's blocking WFI that is apparently needed.  I know it 
doesn't make much sense.


- Paul

