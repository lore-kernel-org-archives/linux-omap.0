From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [RFC][PATCH] DSPBRIDGE: Video Playback Cache Optimization
Date: Tue, 9 Jun 2009 18:18:29 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53040F6B7C82@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60681 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZFIXSk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 19:18:40 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Doyu Hiroshi <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Menon, Nis
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

[sending as plain text to l-o]

Could you please comment on this patch.

=46rom: Sripal Bagadia <bagadia@ti.com>
Date: Tue, 9 Jun 2009 16:05:09 -0500
Subject: [PATCH] DSPBRIDGE: Video Playback Cache Optimization

Avoid get_user_pages cache flush overheads for uncached & reserved
buffers (e.g. display & camera buffers).

Signed-off-by: Sripal Bagadia <bagadia@ti.com>
---
=A0drivers/dsp/bridge/wmd/tiomap3430.c |=A0=A0=A0 4 +++-
=A01 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/w=
md/tiomap3430.c
index 7a9603d..a2f32e8 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1461,7 +1461,9 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_C=
ONTEXT *hDevContext,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto func_cont;
=A0=A0=A0=A0=A0 }
=A0
-=A0=A0=A0=A0 if (vma->vm_flags & VM_IO) {
+=A0=A0=A0=A0 if ((vma->vm_flags & VM_IO) | ((vma->vm_flags & VM_RESERV=
ED) &&=20
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (~pgprot_val(vma->vm_=
page_prot) & L_PTE_CACHEABLE) &&
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (~pgprot_val(vma->vm_=
page_prot) & L_PTE_BUFFERABLE))) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 numUsrPgs =3D=A0 ulNumBytes / PG_SIZE=
_4K;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mpuAddr =3D ulMpuAddr;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DBG_Trace(DBG_LEVEL4, "WMD_BRD_MemMap=
:numOfActualTabEntries=3D%d,"
--=20
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
