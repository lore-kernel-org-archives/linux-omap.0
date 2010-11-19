From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4] OMAP2+: PM: omap device: API's for handling mstandby
 mode
Date: Fri, 19 Nov 2010 09:32:42 -0600
Message-ID: <4CE6989A.7070007@ti.com>
References: <1290151312-347-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:55354 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754679Ab0KSPcq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 10:32:46 -0500
Received: by vws1 with SMTP id 1so2355811vws.9
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 07:32:45 -0800 (PST)
In-Reply-To: <1290151312-347-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

G, Manjunath Kondaiah had written, on 11/19/2010 01:21 AM, the following:
> Certain errata's in OMAP2+ processors will require forcing
> master standby to "no standby" mode before completing on going
> operation. Without this, the results will be unpredictable.
> 
[..]
> These API's are required for multiple DMA errata's which require
> putting DMA controller in no mstandby mode before stopping dma.
> 
> The applicable errata's:
> 1. Errata ID: i557(Applicable for omap36xx all ES versions)
> The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
> through config port while in Standby.
> 
> 2. Errata ID: i541(all omap2plus except omap4)
> sDMA FIFO draining does not finish
> 
> 3. OMAP3430 ES1.0(Errata ID:i88) will require DMA to be put in
> no mstandby mode before disabling the channel after completing
> the data transfer operation.

Minor feedback from what I got from an offline comment:
1 bug = Erratum
1+ bug = Errata

-- 
Regards,
Nishanth Menon
