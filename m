From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: DMA library has redundant API...
Date: Fri, 20 Apr 2007 14:17:23 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08002E0E94C@dbde01.ent.ti.com>
References: <9C23CDD79DA20A479D4615857B2E2C47B678A7@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47B678A7@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Khasim,

omap_get_dma_src_addr_counter() is to get the source position w.r.t to
the address.

I do have a similar thought as you for src_pos().
omap_get_dma_src_pos() is supposed to use the above API to find out the
position of the element in the source buffer that is getting transferred
in terms of frame and element indices.  So this would have different
usage, hence changes to the return value as structure than just address.

Regards,
Senthil.

-----Original Message-----
From: linux-omap-open-source-bounces+svadivu=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+svadivu=3Dti.com@linux.omap.com] =
On
Behalf Of Syed Mohammed, Khasim
Sent: Thursday, April 19, 2007 10:16 PM
To: linux-omap-open-source@linux.omap.com
Subject: DMA library has redundant API...

Hi,

In DMA library we have two functions "omap_get_dma_src_pos" and
"omap_get_dma_src_addr_counter" doing exactly same thing.

I was just curious to know the rational behind this. We can actually add
an API to give current element and frame index for a given DMA channel.

Regards,
Khasim
=20
/*
 * Returns current physical source address for the given DMA channel.
 * If the channel is running the caller must disable interrupts prior
calling
 * this function and process the returned value before re-enabling
interrupt to
 * prevent races with the interrupt handler. Note that in continuous
mode there
 * is a chance for CSSA_L register overflow inbetween the two reads
resulting
 * in incorrect return value.
 */
dma_addr_t omap_get_dma_src_pos(int lch)
{
        dma_addr_t offset;

        if (cpu_class_is_omap1())
                offset =3D (dma_addr_t) (OMAP1_DMA_CSSA_L_REG(lch) |
                                       (OMAP1_DMA_CSSA_U_REG(lch) <<
16));

        if (cpu_is_omap24xx())
                offset =3D OMAP_DMA_CSAC_REG(lch);

        return offset;
}

/*
 * Returns current source transfer counting for the given DMA channel.
 * Can be used to monitor the progress of a transfer inside a block.
 * It must be called with disabled interrupts.
 */
int omap_get_dma_src_addr_counter(int lch)
{
        return (dma_addr_t) OMAP_DMA_CSAC_REG(lch);
}

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
