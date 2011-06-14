From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v2 0/4] drivers/iommu/ relocations
Date: Tue, 14 Jun 2011 12:29:16 +0200
Message-ID: <20110614102916.GF29908@amd.com>
References: <1307742947-32118-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1307742947-32118-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, David Brown <davidb@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 10, 2011 at 05:55:43PM -0400, Ohad Ben-Cohen wrote:
> Ohad Ben-Cohen (4):
>   drivers: iommu: move to a dedicated folder
>   msm: iommu: move to drivers/iommu/
>   x86: amd_iommu: move to drivers/iommu/
>   x86/ia64: intel-iommu: move to drivers/iommu/

Btw, what tree do these patches apply against? I tried to apply them to
v3.0-rc3 and got conflicts. Can you rebase them against -rc3?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
