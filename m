From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 11 May 2012 18:51:00 -0500
Message-ID: <4FADA5E4.80006@ti.com>
References: <4FAAC549.6010206@ti.com> <4FAAE564.6040708@ti.com> <20120510084422.GB27276@mudshark.cambridge.arm.com> <4FAC0F05.3060803@ti.com> <20120511122547.GE17453@mudshark.cambridge.arm.com> <4FAD1865.70003@ti.com> <20120511134920.GC2626@mudshark.cambridge.arm.com> <4FAD27CB.5060102@ti.com> <20120511150223.GD2626@mudshark.cambridge.arm.com> <4FAD3EF3.4080409@ti.com> <20120511163831.GI2626@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47363 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761166Ab2EKXvY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 19:51:24 -0400
In-Reply-To: <20120511163831.GI2626@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Ming Lei <ming.lei@canonical.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Will,

On 05/11/2012 11:38 AM, Will Deacon wrote:
> On Fri, May 11, 2012 at 05:31:47PM +0100, Jon Hunter wrote:
>> Can you send me your .config?
> 
> Sent off-list.
> 
>> At the same time, maybe just try "make omap2plus_defconfig" and enable
>> the OMAP3 debug devices config. That's all I am doing.
> 
> Excellent, that works for me. Once we've worked out the problem with my
> .config you can have my tested-by.

Great! I have been looking at your .config, but I have not been able to
figure out the problem so far. Do you recall what your config is based
upon? I seems quite different to mine and the omap2plus_defconfig has
not changed much in the last few kernel releases.

Cheers
Jon
