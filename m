From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH v2 0/4] OMAP:IOMMU:Add L1 and L2 cache flush
Date: Tue, 19 Jun 2012 16:50:40 +0530
Message-ID: <CADysL2Yr05HUaT7jiqTxmL5dv7mxSpVzXFsJOW9jnsTeiA0E0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4847196518202661740=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

--===============4847196518202661740==
Content-Type: multipart/alternative; boundary=0015175d0578fa0c3304c2d17840

--0015175d0578fa0c3304c2d17840
Content-Type: text/plain; charset=ISO-8859-1

>From 639d8228c118f884e0d04d33331338bf9561700e Mon Sep 17 00:00:00 2001
From: Ramesh Gupta G <grgupta@ti.com>
Date: Fri, 15 Jun 2012 17:06:14 +0530
 Subject: [PATCH v2 0/4] OMAP:IOMMU:Add L1 and L2 cache flush

This patch series is second version to
- add a new cache maintenance api to flush L1 cache
- flush both L1 and L2 caches from iommu whenever the pagetable memory
  is updated.

Added the new api support for ARMv6 and ARMv7
based on the dma functions. The implementation of the
new api is based on the approach[1] discussed some time back.

[1]http://marc.info/?l=linux-kernel&m=131316512713815&w=2

These patches have been validated on Panda Board.

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>

Ramesh Gupta G (4):
  ARM: new cache maintenance api for iommu mem flush
  ARM: add flush_mem api for ARMv6
  ARM: add flush_mem api for ARMv7
  OMAP:IOMMU: flush L1 and L2 caches

 arch/arm/include/asm/cacheflush.h |   17 +++++++++++++++++
 arch/arm/include/asm/glue-cache.h |    1 +
 arch/arm/mm/cache-v6.S            |   28 ++++++++++++++++++++++++++++
 arch/arm/mm/cache-v7.S            |   21 +++++++++++++++++++++
 arch/arm/mm/proc-macros.S         |    1 +
 drivers/iommu/omap-iommu.c        |   26 +++++++++-----------------
 6 files changed, 77 insertions(+), 17 deletions(-)


-- 
regards
Ramesh Gupta G

--0015175d0578fa0c3304c2d17840
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>From 639d8228c118f884e0d04d33331338bf9561700e Mon Sep 17 00:00:00 2001=
</div><div>From: Ramesh Gupta G &lt;<a href=3D"mailto:grgupta@ti.com" targe=
t=3D"_blank">grgupta@ti.com</a>&gt;</div><div>Date: Fri, 15 Jun 2012 17:06:=
14 +0530</div>





<div>
Subject: [PATCH v2 0/4] OMAP:IOMMU:Add L1 and L2 cache flush</div><div><br>=
</div><div>This patch series is second version to</div><div>- add a new cac=
he=A0maintenance api to flush L1 cache</div><div>- flush both=A0L1 and L2 c=
aches from iommu whenever the pagetable memory</div>






<div>=A0 is updated.</div><div><br></div><div>Added the new api support for=
 ARMv6 and ARMv7</div><div>based on the dma functions. The implementation o=
f the</div><div>new api is based on the approach[1] discussed some time bac=
k.</div>

<div><br></div>
<div>[1]<a href=3D"http://marc.info/?l=3Dlinux-kernel&amp;m=3D1313165127138=
15&amp;w=3D2" target=3D"_blank">http://marc.info/?l=3Dlinux-kernel&amp;m=3D=
131316512713815&amp;w=3D2</a></div><div><br></div><div>These patches have b=
een validated on Panda Board.</div>


<div><br></div><div>Signed-off-by: Ramesh Gupta G &lt;<a href=3D"mailto:grg=
upta@ti.com" target=3D"_blank">grgupta@ti.com</a>&gt;</div><div><br></div><=
div>Ramesh Gupta G (4):</div><div>=A0 ARM: new cache maintenance api for io=
mmu mem flush</div>






<div>=A0 ARM: add flush_mem api for ARMv6</div><div>=A0 ARM: add flush_mem =
api for ARMv7</div><div>=A0 OMAP:IOMMU: flush L1 and L2 caches</div><div><b=
r></div><div>=A0arch/arm/include/asm/cacheflush.h | =A0 17 ++++++++++++++++=
+</div>






<div>=A0arch/arm/include/asm/glue-cache.h | =A0 =A01 +</div><div>=A0arch/ar=
m/mm/cache-v6.S =A0 =A0 =A0 =A0 =A0 =A0| =A0 28 +++++++++++++++++++++++++++=
+</div><div>=A0arch/arm/mm/cache-v7.S =A0 =A0 =A0 =A0 =A0 =A0| =A0 21 +++++=
++++++++++++++++</div><div>=A0arch/arm/mm/proc-macros.S =A0 =A0 =A0 =A0 | =
=A0 =A01 +</div>






<div>=A0drivers/iommu/omap-iommu.c =A0 =A0 =A0 =A0| =A0 26 +++++++++-------=
----------</div><div>=A06 files changed, 77 insertions(+), 17 deletions(-)<=
/div><div><br></div><br>-- <br>regards<div>Ramesh Gupta G</div><br>

--0015175d0578fa0c3304c2d17840--


--===============4847196518202661740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4847196518202661740==--
