From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on
 transfer completion
Date: Tue, 19 Jul 2016 22:23:12 +0300
Message-ID: <3baff443-be07-47d1-82a5-f770a116f216@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160714124242.7579-3-peter.ujfalusi@ti.com>
 <20160718103409.GH5783@n2100.arm.linux.org.uk>
 <923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com>
 <20160719162004.GK5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160719162004.GK5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: vinod.koul@intel.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 07/19/2016 07:20 PM, Russell King - ARM Linux wrote:
>> vchan_cookie_complete() will only mark the cookie completed, adds th=
e vd to
>> the desc_completed list (it was deleted from desc_issued list when i=
t was
>> started by omap_dma_start_desc) and schedule the tasklet to deal wit=
h the real
>> completion later.
>> Marking the just finished descriptor/cookie done first then looking =
for
>> possible descriptors in the queue to start feels like a better seque=
nce.
>=20
> I deliberately arranged the code in the original order so that the ne=
xt
> transfer was started on the hardware with the least amount of work by
> the CPU.  Yes, there may not be much in it, but everything you mentio=
n
> above adds to the number of CPU cycles that need to be executed befor=
e
> the next transfer can be started.
>=20
> More CPU cycles wasted means higher latency between transfers, which
> means lower performance.

OK. I will drop this patch in v2.

>> After a quick grep in the kernel source: only omap-dma.c was startin=
g the
>> next transfer before marking the current completed descriptor/cookie=
 done.
>=20
> Right, because I've thought about the issue, having been the author o=
f
> both virt-dma and omap-dma.
>=20


--=20
P=E9ter
