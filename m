From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH 0/8] OMAP4: hwmod data: Add a bunch of IPs
Date: Thu, 17 Feb 2011 16:12:07 +0530
Message-ID: <20110217104207.GB17370@m-desktop>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:56061 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751993Ab1BQKoN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 05:44:13 -0500
Received: by mail-yi0-f50.google.com with SMTP id 15so1157902yic.37
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 02:44:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>, David Lambert <dlambert@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Sumit Semwal <sumit.semwal@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Thu, Feb 17, 2011 at 11:24:41AM +0100, Benoit Cousson wrote:
> All, 
> 
> Due to the important number of modifications recently done on the
> OMAP4 data compared to the original and the total absence of explanation
> in the changelog, I re-submit the data before the driver series in order
> to maintain the integrity of the original file and to avoid a huge pain
> during the merge.
> 
> Govind, Tarun and Kishon, 
> Please note that I cannot include here the dev_attr or rev field for
> McSPI, McBSP and timer since it requires some modification in the device
> header.

McSPI is already merged to l-o master. Will not this series breaks spi
hwmod?

-Manjunath

