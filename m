From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Prepare for GPMC driver conversion
Date: Wed, 13 Jun 2012 04:33:59 -0700
Message-ID: <20120613113358.GL12766@atomide.com>
References: <cover.1339419244.git.afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99803F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47110 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab2FMLeB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 07:34:01 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99803F@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120612 03:32]:
> Hi Tony,
> 
> On Mon, Jun 11, 2012 at 19:31:01, Mohammed, Afzal wrote:
> 
> > Objective of this series is to make things easy for GPMC driver
> > conversion series by separating out more things from driver
> > conversion series.
> > 
> > This series,
> > 1. Unifies NAND platform initialization functions
> > 2. Cleans up OneNAND platform code a little
> > 3. Handles additional timings in Kernel
> > 
> > This series is based on 3.5-rc1 & made on top of
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69501.html
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69881.html
> 
> 
> Please let me know your comments on this series.
> 
> gpmc driver conversion series [1] is dependent on this.

Looks good to me, made one comment regarding testing and maybe disabling
NAND for untested boards if timings change. Are Jon's comments all handled?

Tony
 
> Regards
> Afzal
> 
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69897.html
> 
