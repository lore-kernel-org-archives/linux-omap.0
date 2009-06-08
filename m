From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/4]ARM: OMAP4: SMP: Patch series
Date: Mon, 8 Jun 2009 15:50:44 +0100
Message-ID: <20090608145044.GA32140@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B4BE36E4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37151 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530AbZFHOuy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 10:50:54 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B4BE36E4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Wed, May 27, 2009 at 09:52:38PM +0530, Shilimkar, Santosh wrote:
> I have rebased this series on top of your arm-smp patches and my earlier
> basic omap4 patches.

Can you please rebase your patches on commit c7f7ff1 in my tree (it's
in my devel branch) and I'll merge them in.

(Please don't base patches on the top of the devel branch - you may notice
it's a merge of 'devel-unstable' which is... unstable stuff.)

Thanks.
