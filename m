From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 6/7] iommu/core: add fault reporting
Date: Wed, 7 Sep 2011 19:36:01 +0300
Message-ID: <CAK=WgbafsdQ1MCai05jPsggJ72-jRh1w3OJ4hnuHyYMQauVvKw@mail.gmail.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
	<1314984756-4400-7-git-send-email-ohad@wizery.com>
	<20110905100053.GP16691@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110905100053.GP16691@amd.com>
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

On Mon, Sep 5, 2011 at 1:00 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Please add a seperate function for setting the fault-handler. It is
> optional, so no need to be a value of the alloc-function.

Will do.

> Can you elaborate a bit on what the user of the api will do different
> between IOMMU_TLBMISS and IOMMU_NOPTE?
> My feeling is that those differences should be handled internally in the
> IOMMU driver, but probably I miss a use-case.

I actually agree. Moreover, since we're not planning on implementing
this (dynamic PTE/TLB loading is supported by the hardware, but we're
not really using it ATM), and I don't see any other user doing so at
this point, I'll just remove those two fault types altogether.

> Also, we need some flags to distinguish between the type of the fault
> (read, write, ...).

I'll add it (though it won't be used by OMAP since the hardware
doesn't tell us this info).

Thanks!
Ohad.
