From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 3/3] iommu/core: split mapping to page sizes as supported
	by the hardware
Date: Tue, 13 Sep 2011 15:48:54 +0300
Message-ID: <CAK=Wgbb_DZgH0jvgQr_Rt7G0-Cy0q2pHe+auBOtrFai-D-yMSQ@mail.gmail.com>
References: <1315421604-12286-1-git-send-email-ohad@wizery.com>
	<1315421604-12286-3-git-send-email-ohad@wizery.com>
	<20110913101011.GK11701@amd.com>
	<CAK=WgbbhdFpAHTt=Bku-v1ZOCf48+u+XB-f4yO=5EDojv1kCJg@mail.gmail.com>
	<20110913104433.GL11701@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110913104433.GL11701@amd.com>
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stepan Moskovchenko <stepanm@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 13, 2011 at 1:44 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Not necessarily. You could implement this side-by-side with the old code
> until all drivers are converted and remove the old code then. This keeps
> bisectability.

Ok.

>> > Intel IOMMU does not support arbitrary page-sizes, afaik.
>>
>> It does; besides the usual 4K it has "super page sizes" support of
>> 2MB, 1GB, 512GB and 1TB.
>
> But the value ~0xfffUL indicates support for 4k, 8k, 16k .. 2^63, no?

Yes, I have done this intentionally, in order to retain the existing
behavior for IOMMU drivers which are already capable of handling
arbitrary page sizes (intel-iommu handles this in software, see
hardware_largepage_caps() and the code that uses it).

Long term, it might make more sense to remove
hardware_largepage_caps() (and the logic around it) and instead just
declare the real page sizes the hardware supports when calling
register_iommu(), but I guess it's up to Intel guys. For now it's just
safer to declare ~0xfffUL which really means: keep calling me with
sizes and alignments that are an order of 4KB, just like you always
did.
