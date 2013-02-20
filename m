From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/8] ARM; OMAP2+: hwmod and SERIAL: Remove sysc handling
 from driver
Date: Wed, 20 Feb 2013 15:53:22 +0530
Message-ID: <5124A41A.3010900@ti.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com> <20130220101401.GW17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35958 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab3BTKWK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 05:22:10 -0500
In-Reply-To: <20130220101401.GW17852@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

On Wednesday 20 February 2013 03:44 PM, Russell King - ARM Linux wrote:
> On Wed, Feb 20, 2013 at 03:27:44PM +0530, Santosh Shilimkar wrote:
>> OMAP UART IP needs manual idle modes based on functional state of the
>> IP. Currently this is handled by the driver with function pointers
>> implemented in platform code.
>
> Up until now, the nightly test builds have included a load of test code
> for supporting DMA on OMAP serial - only the buggy transmit side which
> we've covered the reasons earlier why this can't work properly.
>
> We've also covered why the ripping out of the DMA code from the serial
> driver, and then subsequent "cleanup" of the driver has resulted in it
> being impossible to resurect receive DMA support without reverting all
> those cleanups.
>
> This patch set is yet again another nail in the coffin of any DMA support
> in the serial driver; it is removing the final bits of knowledge about
> how DMA support interacts with the idle support.  Arguably, the previous
> cleanups already did that, but at least the hooks were still clearly
> visible as separate stand-alone entities and how only they were affected
> by DMA being enabled.
>
Actually the clean-up will remove the serial driver dependency with
idle handling. Infact DMA support need not care about idle handling
anymore.

> Therefore, tonight I am dropping and discarding what I have left over
> from my work on getting DMA support working with the OMAP serial driver
> again from the nightly test builds and my git tree, and I intend no
> further involvement with this.
>
Please please don't do that. We were at a point where we are unable
to use UART has just simple console with DT without the $subject
series. We can help you if some re-basing is needed for your
patches because of the $subject series.

Sorry for another series getting in between your work but this
one was unavoidable due to already broken support.

Regards,
Santosh



