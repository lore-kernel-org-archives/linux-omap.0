From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v2 4/4] x86/ia64: intel-iommu: move to drivers/iommu/
Date: Fri, 17 Jun 2011 15:18:36 +0200
Message-ID: <20110617131836.GE6689@amd.com>
References: <1307742947-32118-1-git-send-email-ohad@wizery.com>
 <1307742947-32118-5-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:40917
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758854Ab1FQNSQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jun 2011 09:18:16 -0400
Content-Disposition: inline
In-Reply-To: <1307742947-32118-5-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, David Brown <davidb@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jun 10, 2011 at 05:55:47PM -0400, Ohad Ben-Cohen wrote:
> This should ease finding similarities with different platforms,
> with the intention of solving problems once in a generic framework
> which everyone can use.
> 
> Note: to move intel-iommu.c, the declaration of pci_find_upstream_pcie_bridge()
> has to move from drivers/pci/pci.h to include/linux/pci.h. This is handled
> in this patch, too.

David, does this look good to you? Can you send an ACK if so?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

