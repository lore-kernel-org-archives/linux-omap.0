From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Trivial warning fixups.
Date: Tue, 24 Jan 2006 20:07:18 -0800
Message-ID: <20060125040718.GE4966@atomide.com>
References: <20060123141342.GB25124@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060123141342.GB25124@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Mundt <paul.mundt@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Mundt <paul.mundt@nokia.com> [060123 06:21]:
> Bogus type for vfree() in __ioremap_pfn() (should probably use
> remove_vm_area() anyways), and some type mismatches in the OMAP MMC
> driver.
> 
> Signed-off-by: Paul Mundt <paul.mundt@nokia.com>
> 
> ---
> 
>  arch/arm/mm/ioremap.c |    2 +-
>  drivers/mmc/omap.c    |    5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> dfe121170f696b2557e3c43a5aceffa66b739c9c
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index de3ce1e..c45bfea 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -142,7 +142,7 @@ __ioremap_pfn(unsigned long pfn, unsigne
>   		return NULL;
>   	addr = (unsigned long)area->addr;
>   	if (remap_area_pages(addr, pfn, size, flags)) {
> - 		vfree(addr);
> +		vfree((void *)addr);
>   		return NULL;
>   	}
>   	return (void __iomem *) (offset + (char *)addr);

Pushed. Do you want to send the chunk above to RMK?

Tony
