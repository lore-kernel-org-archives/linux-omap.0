From: Steve Poulsen <spoulsen@css-design.us>
Subject: OMAP5912 and McBSP2 with DMA
Date: Tue, 17 Jul 2007 05:55:03 -0500
Message-ID: <469CA007.5090003@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Could someone tell me what the port should be for DMA with McBSP2?  
Since it is an ARM peripheral (as opposed to McBSP1 and McBSP3), then I 
expect it to be as follows.  However, I get a timeout error.

    omap_set_dma_dest_params(cs4384_data.dma_tx_ch,
            OMAP_DMA_PORT_TIPB,
            OMAP_DMA_AMODE_CONSTANT,
            OMAP1610_MCBSP2_BASE + OMAP_MCBSP_REG_DXR2,
            0, 0);

If I change the code to use MCBSP1 (and MPUI as the port), all is well.

Thanks,

Steve
