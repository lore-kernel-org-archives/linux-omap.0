From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/2] dmaengine: omap-dma: Fix cyclic suspend/resume
Date: Wed, 17 Sep 2014 21:38:09 +0300
Message-ID: <5419D511.5010801@ti.com>
References: <1410896757-3848-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410896757-3848-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Vinod,

On 09/16/2014 10:45 PM, Peter Ujfalusi wrote:
> Hi,
>=20
> Changes since v2:
> - fix typo in patch two
> - Acked-by added from Russell
>=20
> When the audio is paused/resumed (application paused the sream or boa=
rd suspend)
> the audio was only playing back one period worth of data and then sto=
ps because
> the omap_dam_stop() clears the link configuration and it is not resto=
red in
> start.
>=20
> Also add memory barrier call to resume path since this could happen r=
ight after
> coming out from suspend.

Would it be possible to queue this two patch for 3.17?
This stop/start issue affects not only board suspend/resume, but in all=
 cases
when application pauses the stream as well when we have underrun in ALS=
A
which would not trigger a full stop and start of audio.

Thanks,
P=E9ter

> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   dmaengine: omap-dma: Add memory barrier to dma_resume path
>   dmaengine: omap-dma: Restore the CLINK_CTRL in resume path
>=20
>  drivers/dma/omap-dma.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
