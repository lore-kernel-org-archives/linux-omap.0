From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH v2 2/4] msm: iommu: move to drivers/iommu/
Date: Mon, 13 Jun 2011 11:26:14 -0700
Message-ID: <8yaips9fv09.fsf@huya.qualcomm.com>
References: <1307742947-32118-1-git-send-email-ohad@wizery.com>
	<1307742947-32118-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1307742947-32118-3-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Sat, 11 Jun 2011 00:55:45 +0300")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <Joerg.Roedel@amd.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 10 2011, Ohad Ben-Cohen wrote:

> This should ease finding similarities with different platforms,
> with the intention of solving problems once in a generic framework
> which everyone can use.
>
> Compile-tested for MSM8X60.

Acked-by: David Brown <davidb@codeaurora.org>

I believe that Stepan Moskovochenko has some extra tests for this code,
but given that none of the code itself changes, I wouldn't expect any
problems.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
