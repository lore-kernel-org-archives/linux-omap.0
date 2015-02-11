From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/2] remoteproc: add support to handle internal memories
Date: Wed, 11 Feb 2015 12:57:58 -0800
Message-ID: <20150211205757.GI2531@atomide.com>
References: <1420838519-15669-1-git-send-email-s-anna@ti.com>
 <1420838519-15669-3-git-send-email-s-anna@ti.com>
 <CAK=WgbaFoUpV315Tg1q=PGc-FkCvKBz2BmO8Fkj_FHa5UuWviw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbaFoUpV315Tg1q=PGc-FkCvKBz2BmO8Fkj_FHa5UuWviw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Robert Tivy <rtivy@ti.com>, Dave Gerlach <d-gerlach@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Ohad Ben-Cohen <ohad@wizery.com> [150210 02:14]:
> Hi Suman,
> 
> On Fri, Jan 9, 2015 at 11:21 PM, Suman Anna <s-anna@ti.com> wrote:
> > A remote processor may need to load certain firmware sections into
> > internal memories (eg: RAM at L1 or L2 levels) for performance or
> > other reasons. Introduce a new resource type (RSC_INTMEM) and add
> > an associated handler function to handle such memories. The handler
> > creates a kernel mapping for the resource's 'pa' (physical address).
> ...
> > + * rproc_handle_intmem() - handle internal memory resource entry
> > + * @rproc: rproc handle
> > + * @rsc: the intmem resource entry
> > + * @offset: offset of the resource data in resource table
> > + * @avail: size of available data (for image validation)
> > + *
> > + * This function will handle firmware requests for mapping a memory region
> > + * internal to a remote processor into kernel. It neither allocates any
> > + * physical pages, nor performs any iommu mapping, as this resource entry
> > + * is primarily used for representing physical internal memories. If the
> > + * internal memory region can only be accessed through an iommu, please
> > + * use a devmem resource entry.
> > + *
> > + * These resource entries should be grouped near the carveout entries in
> > + * the firmware's resource table, as other firmware entries might request
> > + * placing other data objects inside these memory regions (e.g. data/code
> > + * segments, trace resource entries, ...).
> > + */
> > +static int rproc_handle_intmem(struct rproc *rproc, struct fw_rsc_intmem *rsc,
> > +                              int offset, int avail)
> > +{
> ...
> > +       va = (__force void *)ioremap_nocache(rsc->pa, rsc->len);
> 
> Back in the days when we developed remoteproc there was a tremendous
> effort to move away from ioremap when not strictly needed.

The use of ioremap in general is just fine for drivers as long
as they access a dedicated area to the specific device. Accessing
random registers and memory in the SoC is what I'm worried about.
 
> I'd be happy if someone intimate with the related hardware could ack
> that in this specific case ioremap is indeed needed. No need to review
> the entire patch, or anything remoteproc, just make sure that
> generally ioremap is how we want to access this internal memory.
> 
> Tony or Kevin any chance you could take a look and ack?
> 
> If ioremap is indeed the way to go, I'd also expect that we wouldn't
> have to use __force here, but that's probably a minor patch cleanup.

Hmm sounds like this memory should be dedicated to the accelerator?

In that case it should use memblock to reserve that area early so
the kernel won't be accessing it at all.

If it needs to be shared between the kernel and the accelerator,
then is the remoteproc or mailbox somehow needs to coordinating the
shared access to this memory.. I think those cases should be handled
separately and not with a single interface.

Regards,

Tony
