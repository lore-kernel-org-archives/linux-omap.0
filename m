From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 03/26] dmaengine: omap-dma: program hardware
	directly
Date: Wed, 22 Jan 2014 14:13:13 +0000
Message-ID: <20140122141313.GP27282@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk> <E1Vyjtf-0005E5-Vw@rmk-PC.arm.linux.org.uk> <52DFBF89.3020102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:45094 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755868AbaAVONX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jan 2014 09:13:23 -0500
Content-Disposition: inline
In-Reply-To: <52DFBF89.3020102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Wed, Jan 22, 2014 at 06:24:33PM +0530, Sricharan R wrote:
> EI and FI are always set to zero. So interleaved transfers support
> have to enabled in omap-dma, as it was supported by the
> legacy driver. It was not enabled because of no users of the feature,
>  right  ?

None of the users of the legacy driver used this feature.  Moreover,
dmaengine doesn't have the interfaces to support this specialised
feature at present.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
