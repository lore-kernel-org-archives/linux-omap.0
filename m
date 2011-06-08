From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 0/4] drivers/iommu/ relocations
Date: Wed, 8 Jun 2011 16:11:16 +0300
Message-ID: <BANLkTin5JYt4=gru181N_BuvnHB7kUTUeQ@mail.gmail.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com> <20110608130522.GC29089@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20110608130522.GC29089@parisc-linux.org>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, David Brown <davidb@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 8, 2011 at 4:05 PM, Matthew Wilcox <matthew@wil.cx> wrote:
> You've missed at least parisc, ia64, alpha, sparc, powerpc and sh which
> have IOMMUs.

None of these seem to call register_iommu.

> Not that they necessarily all need to be moved across in
> one patchset, but saying "all iommu drivers" is clearly false.

I've moved only the existing IOMMU API users.
