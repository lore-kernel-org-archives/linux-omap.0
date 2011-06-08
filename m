From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 0/4] drivers/iommu/ relocations
Date: Wed, 08 Jun 2011 15:23:10 -0700
Message-ID: <8yar574klo1.fsf@huya.qualcomm.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
	<20110608093546.GG4407@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20110608093546.GG4407@amd.com> (Joerg Roedel's message of "Wed,
	8 Jun 2011 11:35:46 +0200")
Sender: linux-pci-owner@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 08 2011, Roedel, Joerg wrote:

> Great, thanks. I'll apply the patches as soon as the relevant ACKs come
> in. Looking at the MAINTAINERS file David Brown needs to ACK the MSM
> patch and David Woodhouse the VT-d patch.
>
> David B., David W., is this direction ok for both of you?

I think it is a good direction to move in.  I'll reply to the patch
directly to comment on it.

> My suggestion is that the ARM tree pulls in the necessary changes from
> the IOMMU tree and the IOMMU code goes upstream through Ingo or directly
> to Linus (with some time in linux-next, of course). Thoughts?

This seems the cleanest to me.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
