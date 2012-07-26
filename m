From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Thu, 26 Jul 2012 16:05:35 +0100
Message-ID: <20120726150534.GD6382@mudshark.cambridge.arm.com>
References: <4FD64083.3020800@ti.com>
 <20120612092842.GA2991@mudshark.cambridge.arm.com>
 <4FD7B1DC.30108@ti.com>
 <20120612213150.GC24380@mudshark.cambridge.arm.com>
 <4FD7C597.7060501@ti.com>
 <20120702095539.GD22239@mudshark.cambridge.arm.com>
 <4FF1D15E.7040301@ti.com>
 <20120702220117.GD25234@mudshark.cambridge.arm.com>
 <4FF6340A.6020409@ti.com>
 <50109233.3090302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:54017 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751814Ab2GZPGK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 11:06:10 -0400
Content-Disposition: inline
In-Reply-To: <50109233.3090302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, Jul 26, 2012 at 01:41:23AM +0100, Jon Hunter wrote:
> Hi Will,

Hi Jon,

> On 07/05/2012 07:40 PM, Jon Hunter wrote:
> I just wanted to let you know that I have been updating the PMU patches
> for OMAP. Latest can be found here [1]. I have not included Paul's patch
> [2] in this series at the moment, because although it works well for
> OMAP4, I need to create the HWMOD structures for OMAP3. Without these
> structures it breaks OMAP3 PMU support. Once this is done we should be
> able to get rid for the OMAP3 dependency on ETM. Unfortunately, Benoit
> (Mr HWMOD) is out on his holidays but should be back next week and then
> maybe he can give me some guidance on this HWMOD stuff.

Ok, thanks for updating me. I've pushed the patches out onto my
perf/omap4-dev branch as that seems to be a good place to collate the
current state of things. I've not tried doing anything with it yet though.

Do you know when Benoit will be back online?

Will
