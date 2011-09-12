From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH 1/3] iommu/core: add fault reporting mechanism
Date: Mon, 12 Sep 2011 18:02:52 +0200
Message-ID: <20110912160252.GE11701@amd.com>
References: <1315421604-12286-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1315421604-12286-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 07, 2011 at 02:53:22PM -0400, Ohad Ben-Cohen wrote:
>  struct device;
> +struct iommu_domain;
> +
> +/**
> + * enum iommu_fault_types - iommu fault types
> + *
> + * @IOMMU_ERROR: Unrecoverable error
> + *
> + * Currently we only support a generic error fault type.
> + * Future users, which will require more informative fault types, will add
> + * them as needed.
> + */
> +enum iommu_fault_types {
> +	IOMMU_ERROR,
> +};

I still don't get the need for this. It would make sense to encode
different types of faults, like page-faults or interrupt-faults. That is
what I read from the name of the enum.
When I read the comment above it sounds more like you want to encode
different error-levels, like recoverable and unrecoverable error.
The exact meaning of these values need to be clarified.

> +/**
> + * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
> + * @domain: the iommu domain where the fault has happened
> + * @dev: the device where the fault has happened
> + * @iova: the faulting address
> + * @flags: mmu fault flags (e.g. IOMMU_FAULT_READ/IOMMU_FAULT_WRITE/...)
> + * @event: the mmu fault type

Please place 'event' before iova when you keep it, and not at the end.
Then you have 'where' and 'what' of the fault first before the details
(iova, flags).

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
