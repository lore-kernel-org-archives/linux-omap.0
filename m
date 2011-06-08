From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 4/4] x86: intel-iommu: move to drivers/iommu/
Date: Wed, 8 Jun 2011 10:47:34 -0700
Message-ID: <20110608174734.GF23047@sequoia.sous-sol.org>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
	<1307522062-19273-5-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1307522062-19273-5-git-send-email-ohad@wizery.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <Joerg.Roedel@amd.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Ohad Ben-Cohen (ohad@wizery.com) wrote:
> +
> +config DMAR
> +	bool "Support for DMA Remapping Devices (EXPERIMENTAL)"
> +	depends on PCI_MSI && ACPI && EXPERIMENTAL

You may want to further restrict to x86 and ia64
And I think you'll need to fixup arch/ia64/Kconfig

BTW, I think EXPERIMENTAL can be dropped by now.
