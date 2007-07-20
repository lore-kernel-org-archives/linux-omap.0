From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: OMAP5912 and McBSP2 with DMA
Date: Fri, 20 Jul 2007 01:18:40 +0100
Message-ID: <fb249edb0707191718w3fe217dch19ad4192f74c3eaf@mail.gmail.com>
References: <469CA007.5090003@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <469CA007.5090003@css-design.us>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Steve Poulsen <spoulsen@css-design.us>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 17/07/07, Steve Poulsen <spoulsen@css-design.us> wrote:
> Could someone tell me what the port should be for DMA with McBSP2?
> Since it is an ARM peripheral (as opposed to McBSP1 and McBSP3), then I
> expect it to be as follows.  However, I get a timeout error.
>
>     omap_set_dma_dest_params(cs4384_data.dma_tx_ch,
>             OMAP_DMA_PORT_TIPB,
>             OMAP_DMA_AMODE_CONSTANT,
>             OMAP1610_MCBSP2_BASE + OMAP_MCBSP_REG_DXR2,
>             0, 0);

I believe McBSP2 is on the TIPB-MPUI port, which has the value of 5
(as opposed to 3 for TIPB) but I don't remember the macro name.

Cheers
