From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 11 May 2012 17:38:32 +0100
Message-ID: <20120511163831.GI2626@mudshark.cambridge.arm.com>
References: <4FAAC549.6010206@ti.com>
 <4FAAE564.6040708@ti.com>
 <20120510084422.GB27276@mudshark.cambridge.arm.com>
 <4FAC0F05.3060803@ti.com>
 <20120511122547.GE17453@mudshark.cambridge.arm.com>
 <4FAD1865.70003@ti.com>
 <20120511134920.GC2626@mudshark.cambridge.arm.com>
 <4FAD27CB.5060102@ti.com>
 <20120511150223.GD2626@mudshark.cambridge.arm.com>
 <4FAD3EF3.4080409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44443 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753019Ab2EKQjQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 12:39:16 -0400
Content-Disposition: inline
In-Reply-To: <4FAD3EF3.4080409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Ming Lei <ming.lei@canonical.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, May 11, 2012 at 05:31:47PM +0100, Jon Hunter wrote:
> Can you send me your .config?

Sent off-list.

> At the same time, maybe just try "make omap2plus_defconfig" and enable
> the OMAP3 debug devices config. That's all I am doing.

Excellent, that works for me. Once we've worked out the problem with my
.config you can have my tested-by.

Cheers,

Will
