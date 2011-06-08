From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 2/4] msm: iommu: move to drivers/iommu/
Date: Wed, 08 Jun 2011 15:27:10 -0700
Message-ID: <8yamxhsklhd.fsf@huya.qualcomm.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
	<1307522062-19273-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1307522062-19273-3-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Wed, 8 Jun 2011 11:34:20 +0300")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>, stepanm@codeaurora.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <Joerg.Roedel@amd.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 08 2011, Ohad Ben-Cohen wrote:

> This should ease finding similarities with different platforms,
> with the intention of solving problems once in a generic framework
> which everyone can use.
>
> Compile-tested for MSM8X60.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  arch/arm/mach-msm/Kconfig                          |   12 ------------
>  arch/arm/mach-msm/Makefile                         |    2 +-
>  drivers/iommu/Kconfig                              |   11 +++++++++++
>  drivers/iommu/Makefile                             |    1 +
>  .../mach-msm/iommu.c => drivers/iommu/msm-iommu.c  |    0
>  5 files changed, 13 insertions(+), 13 deletions(-)
>  rename arch/arm/mach-msm/iommu.c => drivers/iommu/msm-iommu.c (100%)

Moving the driver is good.  I'm wondering what we should do with
iommu_dev.c, though.  Wouldn't it make sense to move this file as well?

I've added the author, Stepan Moskovchenko, in case he has any feedback.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
