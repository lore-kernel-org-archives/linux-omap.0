From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC] mm: iommu: An API to unify IOMMU, CPU and device memory management
Date: Thu, 24 Jun 2010 12:11:56 +0200
Message-ID: <876318ager.fsf@basil.nowhere.org>
References: <1277355096-15596-1-git-send-email-zpfeffer@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1277355096-15596-1-git-send-email-zpfeffer@codeaurora.org> (Zach
	Pfeffer's message of "Wed, 23 Jun 2010 21:51:36 -0700")
Sender: owner-linux-mm@kvack.org
To: Zach Pfeffer <zpfeffer@codeaurora.org>
Cc: mel@csn.ul.ie, dwalker@codeaurora.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Zach Pfeffer <zpfeffer@codeaurora.org> writes:

> This patch contains the documentation for and the main header file of
> the API, termed the Virtual Contiguous Memory Manager. Its use would
> allow all of the IOMMU to VM, VM to device and device to IOMMU
> interoperation code to be refactored into platform independent code.

I read all the description and it's still unclear what advantage
this all has over the current architecture? 

At least all the benefits mentioned seem to be rather nebulous.

Can you describe a concrete use case that is improved by this code
directly?

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
