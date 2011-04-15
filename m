From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
Date: Fri, 15 Apr 2011 06:26:40 -0500
Message-ID: <BANLkTin8gugnVoai6VHC7qMgK4eKRXRtHg@mail.gmail.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<20110414223036.GA7335@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110414223036.GA7335@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, Hari Kanigeri <h-kanigeri2@ti.com>
List-Id: linux-omap@vger.kernel.org

Russell,

On Thu, Apr 14, 2011 at 5:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo wrote:
>> From: Ramesh Gupta <grgupta@ti.com>
>>
>> This patch is to flush the iommu page table entries from L1 and L2
>> caches using dma_map_single. This also simplifies the implementation
>> by removing the functions =A0flush_iopgd_range/flush_iopte_range.
>
> No. =A0This usage is just wrong. =A0If you're going to use the DMA AP=
I then
> unmap it, otherwise the DMA API debugging will go awol.
>

Thank you for the comments, this particular memory is always a write
from the A9 for MMU programming and
only read from the slave processor, that is the reason for not calling
the unmap. I can re-look into the changes to call
unmap in a proper way as this impacts the DMA API.
Are there any other ways to perform only flush the memory from L1/L2 ca=
ches?

 regards
Ramesh Gupta G
