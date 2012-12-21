From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 09/12] ARM: OMAP2+: powerdomain: skip register reads for
 powerdomains known to be on
Date: Fri, 21 Dec 2012 12:03:33 +0530
Message-ID: <50D402BD.3020402@ti.com>
References: <20121209200108.3196.12452.stgit@dusk.lan> <20121209200327.3196.27686.stgit@dusk.lan> <50D22D0B.3050502@ti.com> <alpine.DEB.2.00.1212201722190.3498@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50502 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab2LUGcy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 01:32:54 -0500
In-Reply-To: <alpine.DEB.2.00.1212201722190.3498@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

On Thursday 20 December 2012 10:52 PM, Paul Walmsley wrote:
> On Wed, 19 Dec 2012, Jon Hunter wrote:
>
>> My understanding is that for OMAP4 devices, the core power domain may
>> not be active the same time as the MPU power domain. The Cortex-A9 has
>> the ability to access some peripherals (such as timer, McBSP) via a
>> private bus that does not require the core domain to be active. This is
>> a difference from OMAP3 devices, where the core would always be on with
>> the MPU power domain.
>
> You are absolutely right and I will drop that part from this patch.
>
Just to be clear, MPU has direct path to ABE domain peripherals on
OMAP4. As Jon pointed out MCBSP and few timers are put under this
domain can be directly accessed by MPU without L3. ABE also can
be accessed via L3 by MPU. ABE has a dual map with MPU.


Regards
Santosh

