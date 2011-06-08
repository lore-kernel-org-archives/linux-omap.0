From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH 0/4] drivers/iommu/ relocations
Date: Wed, 8 Jun 2011 11:35:46 +0200
Message-ID: <20110608093546.GG4407@amd.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:42590
	"EHLO CH1EHSOBE017.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751289Ab1FHJf3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 05:35:29 -0400
Content-Disposition: inline
In-Reply-To: <1307522062-19273-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, David Brown <davidb@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

(Cc'ing Ingo)

On Wed, Jun 08, 2011 at 04:34:18AM -0400, Ohad Ben-Cohen wrote:
> Create a dedicated iommu drivers folder, put the base iommu code there,
> and move the existing IOMMU API users as well (msm-iommu, amd_iommu and
> intel-iommu).
> 
> Putting all iommu drivers together will ease finding similarities
> between different platforms, with the intention of solving problems once,
> in a generic framework, which everyone can use.
> 
> OMAP's iommu will be moved too as soon as it's migrated.

Great, thanks. I'll apply the patches as soon as the relevant ACKs come
in. Looking at the MAINTAINERS file David Brown needs to ACK the MSM
patch and David Woodhouse the VT-d patch.

David B., David W., is this direction ok for both of you?

A more important question is how we handle the IOMMU tree. Currently the
situation is as follows:

	* The AMD IOMMU changes go upstream through Ingo
	* David Woohouse has his own tree which he sents directly to
	  Linus
	* Not sure about the ARM IOMMU code
	* And to comlicate things further there is the upcoming ARM
	  integration tree which may contain code that depends on IOMMU
	  changes

My suggestion is that the ARM tree pulls in the necessary changes from
the IOMMU tree and the IOMMU code goes upstream through Ingo or directly
to Linus (with some time in linux-next, of course). Thoughts?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

