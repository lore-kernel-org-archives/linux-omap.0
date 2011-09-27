From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Tue, 27 Sep 2011 15:12:22 +0200
Message-ID: <20110927131222.GL2138@amd.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
 <1316195506-9777-2-git-send-email-ohad@wizery.com>
 <20110927100505.GH2138@amd.com>
 <CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stepan Moskovchenko <stepanm@codeaurora.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 27, 2011 at 08:26:29AM -0400, Ohad Ben-Cohen wrote:
> > With an unsigned long you can use plain and fast bit_ops instead of the
> > full bitmap functions.
> 
> Not sure I follow; the only bit operation I'm using while mapping is
> find_next_bit() (which is a bitops.h method).
> 
> What other faster variant are you referring to ?

You pass a pointer to an unsigned long for the page-size bitmap. This
allows to use an array of unsigned long. But a single unsigned long is
sufficient and you can use functions like ffs() and fls() together with
shifting. These functions often translate to a single intruction in the
binary. The find_next_bit function has much more overhead because it
needs to handle the array-of-ulong case.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
