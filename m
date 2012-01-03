From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/7] amp/remoteproc: add framework for controlling remote
 processors
Date: Tue, 3 Jan 2012 16:35:34 -0700
Message-ID: <20120103233534.GC2492@ponder.secretlab.ca>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <1319536106-25802-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1319536106-25802-2-git-send-email-ohad@wizery.com>
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
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Brian Swetland <swetland@google.com>, Rusty Russell <rusty@rustcorp.com.au>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 25, 2011 at 11:48:20AM +0200, Ohad Ben-Cohen wrote:
> Modern SoCs typically employ a central symmetric multiprocessing (SMP)
> application processor running Linux, with several other asymmetric
> multiprocessing (AMP) heterogeneous processors running different instances
> of operating system, whether Linux or any other flavor of real-time OS.
> 
> Booting a remote processor in an AMP configuration typically involves:
> - Loading a firmware which contains the OS image
> - Allocating and providing it required system resources (e.g. memory)
> - Programming an IOMMU (when relevant)
> - Powering on the device
> 
> This patch introduces a generic framework that allows drivers to do
> that. In the future, this framework will also include runtime power
> management and error recovery.
> 
> Based on (but now quite far from) work done by Fernando Guzman Lugo
> <fernando.lugo@ti.com>.
[...]
> +static int rproc_load_segments(struct rproc *rproc, const u8 *elf_data)
> +{
> +	struct device *dev = rproc->dev;
> +	struct elf32_hdr *ehdr;
> +	struct elf32_phdr *phdr;
> +	int i, ret = 0;
> +
> +	ehdr = (struct elf32_hdr *)elf_data;
> +	phdr = (struct elf32_phdr *)(elf_data + ehdr->e_phoff);
> +
> +	/* go through the available ELF segments */
> +	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
> +		u32 da = phdr->p_paddr;
> +		u32 memsz = phdr->p_memsz;
> +		u32 filesz = phdr->p_filesz;

This could be an endianess problem.  If the endianess of the host and
the rproc are different, then what is the endianess of the elf file?
Is the endianess of the elf file verified before attempting to parse it?

> +/* handle firmware resource entries before booting the remote processor */
> +static int
> +rproc_handle_boot_rsc(struct rproc *rproc, struct fw_resource *rsc, int len)
> +{
> +	struct device *dev = rproc->dev;
> +	int ret = 0;
> +
> +	while (len >= sizeof(*rsc)) {
> +		dev_dbg(dev, "rsc: type %d, da 0x%llx, pa 0x%llx, len 0x%x, "
> +			"id %d, name %s, flags %x\n", rsc->type, rsc->da,
> +			rsc->pa, rsc->len, rsc->id, rsc->name, rsc->flags);
> +
> +		switch (rsc->type) {
> +		case RSC_CARVEOUT:
> +			ret = rproc_handle_carveout(rproc, rsc);
> +			break;
> +		case RSC_DEVMEM:
> +			ret = rproc_handle_devmem(rproc, rsc);
> +			break;
> +		case RSC_TRACE:
> +			ret = rproc_handle_trace(rproc, rsc);
> +			break;
> +		case RSC_VRING:
> +			ret = rproc_handle_vring(rproc, rsc);
> +			break;
> +		case RSC_VIRTIO_DEV:
> +			/* this one is handled early upon registration */
> +			break;
> +		default:
> +			dev_warn(dev, "unsupported resource %d\n", rsc->type);
> +			break;
> +		}

Nitpick: A look up table would be easier to extend in the future.

Otherwise;

Acked-by: Grant Likely <grant.likely@secretlab.ca>
