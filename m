From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 0/3] OMAP MMU framework patches
Date: Tue, 6 Mar 2007 11:15:03 +0530
Message-ID: <5d5443650703052145m43032469j12b7080852fdbc0d@mail.gmail.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429636DBF@dlee13.ent.ti.com>
	<304D2A85A9643F4A991BDDF8D297BBA605EBFE54@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA605EBFE54@dlee05.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Zhang, Jian" <jzhang@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 3/6/07, Zhang, Jian <jzhang@ti.com> wrote:
> Trilock, Toshihiro and Paul,
>
> I need to enable camera-isp MMU in my 3430 project and hence am looking
> at the MMU framework code posted by Trilock. There are a few questions
> that I like to discuss with you.
>
> - omap_mmu_exmap(): It either maps a physically contiguous buffer to a
> virtually contiguous space (when type!=EXMAP_TYPE_MEM), or allocates a
> set of 1M/64K/4K buffers and maps these buffers to a virtually
> contiguous space (when type==EXMAP_TYPE_MEM). It doesn't seem to me that
> this API can map a set of dis-contiguous pages to a contiguous virtual
> space. The typical camera use case is that we need to map a
> scatter-gather list to a contiguous virtual space. I don't see this is
> supported. Do I miss something here?

Yes, it doesn't handle all the use cases. Take a different case of
IVA1.0 with TI like IVA framework running on co-processors. In that
case we might need to support the memory "malloced" in userspace and
then passed on to gateway which pins down those pages with
"get_user_pages" like call and then maps to IVA MMU. The current MMU
fwk is highly tied to DSP's requirement. You are free to change it to
suite your case.

>
> - The same API also checks the TLB. A mapping request is denied if TLB
> is full. Camera MMU has only 8 TLB entries. TLB-only approach is almost
> certainly impossible. Is the framework allowing the underlying MMU
> driver to use table walking logic? This is not clear to me as the struct
> omap_mmu_ops doesn't have enough comments.

True. Again in case of IVA we have tried TWL and it was working, but
the code was in very much preliminary stages and not clean. Yes, 32
TLB entries in case of DSP and IVA is also not enough as we could
easily run out of it so the current approach is not scalable.

>
> - Can you send me the driver code that actually calls omap_mmu_register?
> Knowing how a mmu driver should be written definitely helps
> understanding this mmu framework.

Please check my patches on MMU framework - dsp_mem.c

-- 
--Trilok Soni
