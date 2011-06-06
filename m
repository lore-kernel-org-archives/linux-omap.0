From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 0/6] iommu: generic api migration and grouping
Date: Mon, 6 Jun 2011 23:09:33 +0300
Message-ID: <BANLkTinx21-E3DRe9D7LRB8e1aeOwv=-9A@mail.gmail.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
 <20110606100950.GC30762@amd.com> <BANLkTi=i2s-Ujiy4qn_XQv+9dMjUC9R66A@mail.gmail.com>
 <20110606153557.GE1953@amd.com> <BANLkTinwwVO4TmsxuTfSBf6jqYrEVV3b_A@mail.gmail.com>
 <20110606192030.GA4356@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110606192030.GA4356@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "arnd@arndb.de" <arnd@arndb.de>, "davidb@codeaurora.org" <davidb@codeaurora.org>, Omar Ramirez Luna <omar.ramirez@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 6, 2011 at 10:20 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Well, it certainly makes sense to have a single implementation for this.
> But I want to hide this complexity to the user of the IOMMU-API. The
> best choice is to put this into the layer between the IOMMU-API and the
> backend implementation.

I agree.

The IOMMU API should take physically contiguous regions from the user,
split them up according to page-sizes (/alignment requirements)
supported by the hardware, and then tell the underlying implementation
what to map where.

> That interface is not put into stone. There were other complains about
> the ->unmap part recently, so there is certainly room for improvement
> there.

Once the supported page sizes are exposed to the framework, the
current ->unmap API should probably be enough. 'va' + 'order' sounds
like all the information an implementation needs to unmap a page.
