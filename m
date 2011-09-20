From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/7] Add L2 cache cleaning to generic CPU suspend
Date: Tue, 20 Sep 2011 16:14:52 +0530
Message-ID: <4E786EA4.9020900@ti.com>
References: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:46912 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753957Ab1ITKo6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 06:44:58 -0400
Received: by gwj17 with SMTP id 17so257748gwj.38
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 03:44:57 -0700 (PDT)
In-Reply-To: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 19 September 2011 10:07 PM, Russell King - ARM Linux wrote:
> This is a re-post of the previous patch series, but with an additional
> TLB flush to ensure that hte global TLB entry in the page tables is
> flushed out.  This is a flush of all TLB entries, but it could probably
> be more targetted if we need to.
> 
I have tried this seven patches + already merged 4 patches against RC4
and OMAP4 PM patches and they continue to work as expected.

I guess once Lorenzo confirms that his userspace segmentation faults
are fixed with the TLB flush updates, the series is good for the merge.

Regards
Santosh
