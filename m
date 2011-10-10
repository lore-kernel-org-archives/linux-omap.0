From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Mon, 10 Oct 2011 16:00:48 +0200
Message-ID: <CAK=WgbbzPmdtH9J2H0-jh+NipJ+GenEkkqorMLZpPU+xmZ3C4w@mail.gmail.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
 <1316195506-9777-2-git-send-email-ohad@wizery.com> <20110927100505.GH2138@amd.com>
 <CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
 <20110927131222.GL2138@amd.com> <CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
 <20110927181438.GM2138@amd.com> <CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
 <CAHQjnOOhtSiivWf34S8mjB9nqQfUwadLzE8zOm4jYvsgL_d+Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHQjnOOhtSiivWf34S8mjB9nqQfUwadLzE8zOm4jYvsgL_d+Wg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KyongHo Cho <pullip.cho@samsung.com>
Cc: "Roedel, Joerg" <Joerg.Roedel@amd.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stepan Moskovchenko <stepanm@codeaurora.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 10, 2011 at 2:52 PM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> Do not we need to unmap all intermediate mappings if iommu_map() is failed?

Good idea, I'll add it.

Thanks!
Ohad.
