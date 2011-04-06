From: Juha Kuikka <juha.kuikka@gmail.com>
Subject: Issue with DSS DSI: Complex IO not powering on
Date: Tue, 5 Apr 2011 18:55:44 -0700
Message-ID: <BANLkTinPpuxnTA5MFZnfEaNeAS5rSYK79w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53797 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126Ab1DFBzq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 21:55:46 -0400
Received: by bwz15 with SMTP id 15so771929bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 18:55:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hi,
I am working on a custom board with DM3730 and a DSI panel and I have
a problem in powering on the DSI complex IO block.

The DSS DSI initialization fails with:
omapdss DSI: dsi_complexio_init
omapdss DSI error: complexio reset not done! =A0<-- my own addition
omapdss DSI error: failed to set complexio power state to 1

The DSI PLL is used and configured according to the example values in
the TRM (not proper for our panel but they should enable the complex
IO to at least power on, right).

Output form DSS DEBUG:
omapdss DSI: LP_CLK_DIV 6, LP_CLK 7500000
omapdss DISPC: lck =3D 90000000 (1)
omapdss DISPC: pck =3D 30000000 (3)
- DSI PLL -
dsi pll source =3D dss2_alwon_fclk
=46int 2000000 =A0 =A0 =A0 =A0 regn 13
CLKIN4DDR 1080000000 =A0 =A0 =A0regm 270
dsi1_pll_fck 90000000 =A0 =A0 =A0 =A0regm3 12 (on)
dsi2_pll_fck 90000000 =A0 =A0 =A0 =A0regm4 12 (on)
- DSI -
dsi fclk source =3D dsi2_pll_fclk
DSI_FCLK 90000000
DDR_CLK 270000000
TxByteClkHS 67500000
LP_CLK 7500000
VP_CLK 90000000
VP_PCLK 30000000

As far as I can tell these values fill all the requirements set in the
TRM for clock rates and their ratios.

After the fail in dsi_complexio_init I dump all registers:

DSI_REVISION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000010
DSI_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000011
DSI_SYSSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000001
DSI_IRQSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00080080
DSI_IRQENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00000010=
0
DSI_COMPLEXIO_CFG1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A048200321
DSI_COMPLEXIO_IRQ_STATUS =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_COMPLEXIO_IRQ_ENABLE =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_CLK_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0a0304006
DSI_TIMING1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 7fff7fff
DSI_TIMING2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 7fff7fff
DSI_VM_TIMING1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VM_TIMING2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VM_TIMING3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_CLK_TIMING =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000101
DSI_TX_FIFO_VC_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_RX_FIFO_VC_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_COMPLEXIO_CFG2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_RX_FIFO_VC_FULLNESS =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_VM_TIMING4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_TX_FIFO_VC_EMPTINESS =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VM_TIMING5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VM_TIMING6 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VM_TIMING7 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_STOPCLK_TIMING =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000080
DSI_VC_CTRL(0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VC_TE(0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VC_LONG_PACKET_HEADER(0) =A0 =A0 =A0 =A000000000
DSI_VC_LONG_PACKET_PAYLOAD(0) =A0 =A0 =A0 00000000
DSI_VC_SHORT_PACKET_HEADER(0) =A0 =A0 =A0 00000000
DSI_VC_IRQSTATUS(0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_VC_IRQENABLE(0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_VC_CTRL(1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VC_TE(1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VC_LONG_PACKET_HEADER(1) =A0 =A0 =A0 =A000000000
DSI_VC_LONG_PACKET_PAYLOAD(1) =A0 =A0 =A0 00000000
DSI_VC_SHORT_PACKET_HEADER(1) =A0 =A0 =A0 00000000
DSI_VC_IRQSTATUS(1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_VC_IRQENABLE(1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_VC_CTRL(2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VC_TE(2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VC_LONG_PACKET_HEADER(2) =A0 =A0 =A0 =A000000000
DSI_VC_LONG_PACKET_PAYLOAD(2) =A0 =A0 =A0 00000000
DSI_VC_SHORT_PACKET_HEADER(2) =A0 =A0 =A0 00000000
DSI_VC_IRQSTATUS(2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_VC_IRQENABLE(2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_VC_CTRL(3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VC_TE(3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_VC_LONG_PACKET_HEADER(3) =A0 =A0 =A0 =A000000000
DSI_VC_LONG_PACKET_PAYLOAD(3) =A0 =A0 =A0 00000000
DSI_VC_SHORT_PACKET_HEADER(3) =A0 =A0 =A0 00000000
DSI_VC_IRQSTATUS(3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_VC_IRQENABLE(3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_DSIPHY_CFG0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1e481d3a
DSI_DSIPHY_CFG1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 420a1a6a
DSI_DSIPHY_CFG2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 b800001a
DSI_DSIPHY_CFG5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 60000000
DSI_PLL_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000
DSI_PLL_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000383
DSI_PLL_GO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A000000000
DSI_PLL_CONFIGURATION1 =A0 =A0 =A0 =A0 =A0 =A0 =A005d90e19
DSI_PLL_CONFIGURATION2 =A0 =A0 =A0 =A0 =A0 =A0 =A00005600e

Of special interest is the DSI_COMPLEXIO_CFG1. RESET_DONE is not set,
not does the PWR_STATUS match the command given. The
LDO_POWER_GOOD_STATE is asserted however.

The DSI is powered and all the clocks seem to be on and the DSI PLL
locks. Just the complex IO will not power on. I am using a 2.6.32.9
kernel so it is not the latest but I wanted to ask if someone had any
idea where to look next before porting the latest onto our board.

Thanks,
 - Juha

--
Duck tape is like the force, it has a light side and a dark side and
it holds the universe together.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
