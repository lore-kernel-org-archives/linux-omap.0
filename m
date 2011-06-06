From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [RFC 0/6] iommu: generic api migration and grouping
Date: Mon, 6 Jun 2011 17:35:57 +0200
Message-ID: <20110606153557.GE1953@amd.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
 <20110606100950.GC30762@amd.com>
 <BANLkTi=i2s-Ujiy4qn_XQv+9dMjUC9R66A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=i2s-Ujiy4qn_XQv+9dMjUC9R66A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "arnd@arndb.de" <arnd@arndb.de>, "davidb@codeaurora.org" <davidb@codeaurora.org>, Omar Ramirez Luna <omar.ramirez@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 06, 2011 at 11:15:30AM -0400, Ohad Ben-Cohen wrote:

> This is insufficient; users need somehow to tell what page sizes are
> supported by the underlying hardware (we can't assume host page-sizes,
> and we want to use bigger pages whenever possible, to relax the TLB
> pressure).
/
What does the IOMMU-API user need this info for? On the x86 IOMMUs these
details are handled transparently by the IOMMU driver.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
