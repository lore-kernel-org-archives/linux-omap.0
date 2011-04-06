From: Archit Taneja <archit@ti.com>
Subject: Re: Issue with DSS DSI: Complex IO not powering on
Date: Wed, 6 Apr 2011 11:46:19 +0530
Message-ID: <4D9C0533.7030501@ti.com>
References: <BANLkTinPpuxnTA5MFZnfEaNeAS5rSYK79w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44285 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056Ab1DFGLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Apr 2011 02:11:48 -0400
In-Reply-To: <BANLkTinPpuxnTA5MFZnfEaNeAS5rSYK79w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hi,

On Wednesday 06 April 2011 07:25 AM, Juha Kuikka wrote:
> Hi,
> I am working on a custom board with DM3730 and a DSI panel and I have
> a problem in powering on the DSI complex IO block.
>
> The DSS DSI initialization fails with:
> omapdss DSI: dsi_complexio_init
> omapdss DSI error: complexio reset not done!<-- my own addition
> omapdss DSI error: failed to set complexio power state to 1
>
Can you check if the necessary pad/pin-muxing has been done for the DSI 
lanes?

Archit
> The DSI PLL is used and configured according to the example values in
> the TRM (not proper for our panel but they should enable the complex
> IO to at least power on, right).
>
> Output form DSS DEBUG:
> omapdss DSI: LP_CLK_DIV 6, LP_CLK 7500000
> omapdss DISPC: lck = 90000000 (1)
> omapdss DISPC: pck = 30000000 (3)
> - DSI PLL -
> dsi pll source = dss2_alwon_fclk
> Fint 2000000         regn 13
> CLKIN4DDR 1080000000      regm 270
> dsi1_pll_fck 90000000        regm3 12 (on)
> dsi2_pll_fck 90000000        regm4 12 (on)
> - DSI -
> dsi fclk source = dsi2_pll_fclk
> DSI_FCLK 90000000
> DDR_CLK 270000000
> TxByteClkHS 67500000
> LP_CLK 7500000
> VP_CLK 90000000
> VP_PCLK 30000000
>
> As far as I can tell these values fill all the requirements set in the
> TRM for clock rates and their ratios.
>
> After the fail in dsi_complexio_init I dump all registers:
>
> DSI_REVISION                        00000010
> DSI_SYSCONFIG                       00000011
> DSI_SYSSTATUS                       00000001
> DSI_IRQSTATUS                       00080080
> DSI_IRQENABLE                       00000000
> DSI_CTRL                            00000100
> DSI_COMPLEXIO_CFG1                  48200321
> DSI_COMPLEXIO_IRQ_STATUS            00000000
> DSI_COMPLEXIO_IRQ_ENABLE            00000000
> DSI_CLK_CTRL                        a0304006
> DSI_TIMING1                         7fff7fff
> DSI_TIMING2                         7fff7fff
> DSI_VM_TIMING1                      00000000
> DSI_VM_TIMING2                      00000000
> DSI_VM_TIMING3                      00000000
> DSI_CLK_TIMING                      00000101
> DSI_TX_FIFO_VC_SIZE                 00000000
> DSI_RX_FIFO_VC_SIZE                 00000000
> DSI_COMPLEXIO_CFG2                  00000000
> DSI_RX_FIFO_VC_FULLNESS             00000000
> DSI_VM_TIMING4                      00000000
> DSI_TX_FIFO_VC_EMPTINESS            00000000
> DSI_VM_TIMING5                      00000000
> DSI_VM_TIMING6                      00000000
> DSI_VM_TIMING7                      00000000
> DSI_STOPCLK_TIMING                  00000080
> DSI_VC_CTRL(0)                      00000000
> DSI_VC_TE(0)                        00000000
> DSI_VC_LONG_PACKET_HEADER(0)        00000000
> DSI_VC_LONG_PACKET_PAYLOAD(0)       00000000
> DSI_VC_SHORT_PACKET_HEADER(0)       00000000
> DSI_VC_IRQSTATUS(0)                 00000000
> DSI_VC_IRQENABLE(0)                 00000000
> DSI_VC_CTRL(1)                      00000000
> DSI_VC_TE(1)                        00000000
> DSI_VC_LONG_PACKET_HEADER(1)        00000000
> DSI_VC_LONG_PACKET_PAYLOAD(1)       00000000
> DSI_VC_SHORT_PACKET_HEADER(1)       00000000
> DSI_VC_IRQSTATUS(1)                 00000000
> DSI_VC_IRQENABLE(1)                 00000000
> DSI_VC_CTRL(2)                      00000000
> DSI_VC_TE(2)                        00000000
> DSI_VC_LONG_PACKET_HEADER(2)        00000000
> DSI_VC_LONG_PACKET_PAYLOAD(2)       00000000
> DSI_VC_SHORT_PACKET_HEADER(2)       00000000
> DSI_VC_IRQSTATUS(2)                 00000000
> DSI_VC_IRQENABLE(2)                 00000000
> DSI_VC_CTRL(3)                      00000000
> DSI_VC_TE(3)                        00000000
> DSI_VC_LONG_PACKET_HEADER(3)        00000000
> DSI_VC_LONG_PACKET_PAYLOAD(3)       00000000
> DSI_VC_SHORT_PACKET_HEADER(3)       00000000
> DSI_VC_IRQSTATUS(3)                 00000000
> DSI_VC_IRQENABLE(3)                 00000000
> DSI_DSIPHY_CFG0                     1e481d3a
> DSI_DSIPHY_CFG1                     420a1a6a
> DSI_DSIPHY_CFG2                     b800001a
> DSI_DSIPHY_CFG5                     60000000
> DSI_PLL_CONTROL                     00000000
> DSI_PLL_STATUS                      00000383
> DSI_PLL_GO                          00000000
> DSI_PLL_CONFIGURATION1              05d90e19
> DSI_PLL_CONFIGURATION2              0005600e
>
> Of special interest is the DSI_COMPLEXIO_CFG1. RESET_DONE is not set,
> not does the PWR_STATUS match the command given. The
> LDO_POWER_GOOD_STATE is asserted however.
>
> The DSI is powered and all the clocks seem to be on and the DSI PLL
> locks. Just the complex IO will not power on. I am using a 2.6.32.9
> kernel so it is not the latest but I wanted to ask if someone had any
> idea where to look next before porting the latest onto our board.
>
> Thanks,
>   - Juha
>
> --
> Duck tape is like the force, it has a light side and a dark side and
> it holds the universe together.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

