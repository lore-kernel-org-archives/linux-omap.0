From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/3] iommu/core: add fault reporting mechanism
Date: Tue, 13 Sep 2011 13:19:56 +0300
Message-ID: <CAK=WgbZ0TGDevR+HP=KmE1DDanSwCxOnpNf_wn2UfRATALJHcw@mail.gmail.com>
References: <1315421604-12286-1-git-send-email-ohad@wizery.com>
	<20110912160252.GE11701@amd.com>
	<CAK=WgbZCDsBk+dueKfAX3ewsvqEnVDN+jW_ftW+BDKnayunOwA@mail.gmail.com>
	<20110913100034.GJ11701@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110913100034.GJ11701@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 13, 2011 at 1:00 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> For now I think it is the best to remove this IOMMU_ERROR thing. It is
> inherent to the function call already. When a real use-case comes up we
> can easily add it later.

I'm fine with this, will post an update.

Thanks,
Ohad.
