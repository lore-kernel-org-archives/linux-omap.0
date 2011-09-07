From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 7/7] iommu/core: split mapping to page sizes as supported by
	the hardware
Date: Wed, 7 Sep 2011 12:49:06 +0300
Message-ID: <CAK=Wgbayt0D8u8u_t=Zs=15A0YBjKX3RUNtWFKVCOxEOKvH7fw@mail.gmail.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
	<1314984756-4400-8-git-send-email-ohad@wizery.com>
	<CAHQjnOMT3UOFMi=JbSXf4-s_BbZ+fSGbOEjxwT7t7N-zd+9-zg@mail.gmail.com>
	<CAK=WgbZPFryzCFLa5AhAYDmH1S8c3x-OsSTyxYeq0WLAe8VyTg@mail.gmail.com>
	<CAHQjnOMnOjAJ6QuuLmLa1UKvTRHfyyjiUYrfvzLx8FSsCixxng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHQjnOMnOjAJ6QuuLmLa1UKvTRHfyyjiUYrfvzLx8FSsCixxng@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: KyongHo Cho <pullip.cho@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <Joerg.Roedel@amd.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

[resending due to mailer-daemon errors I got, sorry]

Hi KyongHo,

On Wed, Sep 7, 2011 at 11:05 AM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> However, it is faster because it does not calculate the given order and
> not call any function.

Hmm this sounds a bit like a red herring to me; optimization of the
map function is not the main subject here. Especially not when we're
discussing mapping of large physically contiguous memory regions which
do not happen too often.

But generally I don't think that duplicating code and eliminating
function calls is a good optimization (the compiler can do that for
us..). Moreover, it looks like s5p_iommu_map() gives a higher priority
for bigger pages first, and only reaches 4KB pages after it tried all
other supported pages. IMHO that's sub-optimal, because small mappings
are more common than big ones.

Another advantage for migrating s5p_iommu_map() over to the subject
patch, is that s5p_iommu_map() doesn't support super sections yet. To
support it, you'd need to add more code (duplicate another while
loop). But if you migrated to the subject patch, then you would only
need to flip the 16MB bit when you advertise page size capabilities
and then that's it; you're done.

> It is a logical error because the caller of iommu_map() gives
> 4KB aligned physical address while saying that it is 64KB aligned.

The caller of iommu_map() doesn't say anything about alignments. It
just gives it a memory region to map, and expect things to just work.

Obviously it's better if big physically contiguous mapping will be
aligned to big pages, but things can still work even if it's not, by
using smaller pages. No reason not to provide this flexibility.

The only requirement the IOMMU API should have is the minimum 4KB
alignment, because IOMMU hardware does not support smaller pages.

Thanks,
Ohad.
