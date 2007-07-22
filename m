From: "Oleg Kechin" <okechin@gmail.com>
Subject: Re: OMAP5912 and McBSP2 with DMA
Date: Sun, 22 Jul 2007 12:29:20 +0300
Message-ID: <ce87d8040707220229v6a7c83b4q4e2cd78e3834dc5@mail.gmail.com>
References: <469CA007.5090003@css-design.us>
	<fb249edb0707191718w3fe217dch19ad4192f74c3eaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0707191718w3fe217dch19ad4192f74c3eaf@mail.gmail.com>
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
To: Steve Poulsen <spoulsen@css-design.us>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 7/20/07, andrzej zaborowski <balrogg@gmail.com> wrote:
>
> Hi,
>
> On 17/07/07, Steve Poulsen <spoulsen@css-design.us> wrote:
> > Could someone tell me what the port should be for DMA with McBSP2?
> > Since it is an ARM peripheral (as opposed to McBSP1 and McBSP3), then I
> > expect it to be as follows.  However, I get a timeout error.
> >
> >     omap_set_dma_dest_params(cs4384_data.dma_tx_ch,
> >             OMAP_DMA_PORT_TIPB,
> >             OMAP_DMA_AMODE_CONSTANT,
> >             OMAP1610_MCBSP2_BASE + OMAP_MCBSP_REG_DXR2,
> >             0, 0);
>
> I believe McBSP2 is on the TIPB-MPUI port, which has the value of 5
> (as opposed to 3 for TIPB) but I don't remember the macro name.
>
> Cheers
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>

I disagree.
===
" but the MPUI port is a dedicated port used for MPU or system DMA initiated
transfers
to DSP subsystem resources."
===
sprs231b.pdf page 165. So for MCBSP2 port type is TIPB bus I think. (I use
it by myself in OMAP5910 and it is work fine).
