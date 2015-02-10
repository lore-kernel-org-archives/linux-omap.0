From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 2/2] remoteproc: add support to handle internal memories
Date: Tue, 10 Feb 2015 12:10:44 +0200
Message-ID: <CAK=WgbaFoUpV315Tg1q=PGc-FkCvKBz2BmO8Fkj_FHa5UuWviw@mail.gmail.com>
References: <1420838519-15669-1-git-send-email-s-anna@ti.com> <1420838519-15669-3-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420838519-15669-3-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Robert Tivy <rtivy@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Fri, Jan 9, 2015 at 11:21 PM, Suman Anna <s-anna@ti.com> wrote:
> A remote processor may need to load certain firmware sections into
> internal memories (eg: RAM at L1 or L2 levels) for performance or
> other reasons. Introduce a new resource type (RSC_INTMEM) and add
> an associated handler function to handle such memories. The handler
> creates a kernel mapping for the resource's 'pa' (physical address).
...
> + * rproc_handle_intmem() - handle internal memory resource entry
> + * @rproc: rproc handle
> + * @rsc: the intmem resource entry
> + * @offset: offset of the resource data in resource table
> + * @avail: size of available data (for image validation)
> + *
> + * This function will handle firmware requests for mapping a memory region
> + * internal to a remote processor into kernel. It neither allocates any
> + * physical pages, nor performs any iommu mapping, as this resource entry
> + * is primarily used for representing physical internal memories. If the
> + * internal memory region can only be accessed through an iommu, please
> + * use a devmem resource entry.
> + *
> + * These resource entries should be grouped near the carveout entries in
> + * the firmware's resource table, as other firmware entries might request
> + * placing other data objects inside these memory regions (e.g. data/code
> + * segments, trace resource entries, ...).
> + */
> +static int rproc_handle_intmem(struct rproc *rproc, struct fw_rsc_intmem *rsc,
> +                              int offset, int avail)
> +{
...
> +       va = (__force void *)ioremap_nocache(rsc->pa, rsc->len);

Back in the days when we developed remoteproc there was a tremendous
effort to move away from ioremap when not strictly needed.

I'd be happy if someone intimate with the related hardware could ack
that in this specific case ioremap is indeed needed. No need to review
the entire patch, or anything remoteproc, just make sure that
generally ioremap is how we want to access this internal memory.

Tony or Kevin any chance you could take a look and ack?

If ioremap is indeed the way to go, I'd also expect that we wouldn't
have to use __force here, but that's probably a minor patch cleanup.

Thanks,
Ohad.
