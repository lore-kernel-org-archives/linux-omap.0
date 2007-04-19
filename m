From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: DMA library has redundant API...
Date: Thu, 19 Apr 2007 11:46:02 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47B678A7@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

In DMA library we have two functions "omap_get_dma_src_pos" and =
"omap_get_dma_src_addr_counter" doing exactly same thing.

I was just curious to know the rational behind this. We can actually add =
an API to give current element and frame index for a given DMA channel.

Regards,
Khasim
=20
/*
 * Returns current physical source address for the given DMA channel.
 * If the channel is running the caller must disable interrupts prior =
calling
 * this function and process the returned value before re-enabling =
interrupt to
 * prevent races with the interrupt handler. Note that in continuous =
mode there
 * is a chance for CSSA_L register overflow inbetween the two reads =
resulting
 * in incorrect return value.
 */
dma_addr_t omap_get_dma_src_pos(int lch)
{
        dma_addr_t offset;

        if (cpu_class_is_omap1())
                offset =3D (dma_addr_t) (OMAP1_DMA_CSSA_L_REG(lch) |
                                       (OMAP1_DMA_CSSA_U_REG(lch) << =
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
