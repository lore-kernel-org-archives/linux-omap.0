From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on
 transfer completion
Date: Tue, 19 Jul 2016 15:35:18 +0300
Message-ID: <923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160714124242.7579-3-peter.ujfalusi@ti.com>
 <20160718103409.GH5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160718103409.GH5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: vinod.koul@intel.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 07/18/16 13:34, Russell King - ARM Linux wrote:
> On Thu, Jul 14, 2016 at 03:42:37PM +0300, Peter Ujfalusi wrote:
>> Before looking for the next descriptor to start, complete the just f=
inished
>> cookie.
>=20
> This change will reduce performance as we no longer have an overlap
> between the next request starting to be dealt with in the hardware
> vs the previous request being completed.

vchan_cookie_complete() will only mark the cookie completed, adds the v=
d to
the desc_completed list (it was deleted from desc_issued list when it w=
as
started by omap_dma_start_desc) and schedule the tasklet to deal with t=
he real
completion later.
Marking the just finished descriptor/cookie done first then looking for
possible descriptors in the queue to start feels like a better sequence=
=2E

After a quick grep in the kernel source: only omap-dma.c was starting t=
he next
transfer before marking the current completed descriptor/cookie done.

> Your commit log doesn't
> say _why_ the change is being made, it merely tells us what the
> patch is doing, which we can see already.
>=20
> Please describe changes a little better.
>=20


--=20
P=E9ter
