From: Archit Taneja <archit@ti.com>
Subject: Re: Issue with DSS DSI: Complex IO not powering on
Date: Thu, 7 Apr 2011 11:15:01 +0530
Message-ID: <4D9D4F5D.40207@ti.com>
References: <BANLkTinPpuxnTA5MFZnfEaNeAS5rSYK79w@mail.gmail.com>	<4D9C0533.7030501@ti.com> <BANLkTi=NVDw9DkOEqwDC71KADnJ2VJy5iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57799 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab1DGFkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 01:40:25 -0400
In-Reply-To: <BANLkTi=NVDw9DkOEqwDC71KADnJ2VJy5iQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hi,

On Thursday 07 April 2011 08:19 AM, Juha Kuikka wrote:
> On Tue, Apr 5, 2011 at 11:16 PM, Archit Taneja<archit@ti.com>  wrote:
>> Hi,
>>
>> On Wednesday 06 April 2011 07:25 AM, Juha Kuikka wrote:
>>>
>>> Hi,
>>> I am working on a custom board with DM3730 and a DSI panel and I have
>>> a problem in powering on the DSI complex IO block.
>>>
>>> The DSS DSI initialization fails with:
>>> omapdss DSI: dsi_complexio_init
>>> omapdss DSI error: complexio reset not done!<-- my own addition
>>> omapdss DSI error: failed to set complexio power state to 1
>>>
>> Can you check if the necessary pad/pin-muxing has been done for the DSI
>> lanes?
>
> Thank you for the advice! Turns out they were not. After configuring
> them the DSI powers on correctly.
>
> Unfortunately I ran into another issue, it seems that dispc is not
> giving us FRAMEDONE interrupt, currently investigating why.
>
> Any input is appreciated.

A couple of questions:

It is a command mode or video mode panel?
Are other commands to the panel going through successfully?
Could you point to the kernel source you are using?

>
> Clocking:
> omapdss DSI: PLL init
> omapdss DSI: PLL init done
> omapdss DSI: dsi_pll_set_clock_div()
> omapdss DSI: DSI Fint 2000000
> omapdss DSI: clkin (dss2_fck) rate 26000000, highfreq 0
> omapdss DSI: CLKIN4DDR = 2 * 180 / 13 * 26000000 / 1 = 720000000
> omapdss DSI: Data rate on 1 DSI lane 360 Mbps
> omapdss DSI: Clock lane freq 180000000 Hz
> omapdss DSI: regm3 = 8, dsi1_pll_fclk = 90000000
> omapdss DSI: regm4 = 8, dsi2_pll_fclk = 90000000
> omapdss DSI: PLL config done
> omapdss DSI: PLL OK
> omapdss DISPC: lck = 90000000 (1)
> omapdss DISPC: pck = 30000000 (3)
>

90 Mhz for DISPC and DSI FCLK seems to be a bit low, you may want to 
increase that.

Archit

> DISPC is using DSI_DPLL1 as fclk.
>
> Logs:
> mapdss MANAGER: omap_dss_mgr_apply(lcd)
> omapdss OVERLAY: check_overlay 0: (0,0 480x800 ->  0x800) disp (480x800)
> omapdss MANAGER: configure_overlay(0)
> omapdss DISPC: dispc_setup_plane 0, pa 81430000, sw 480, 0,0, 480x800
> ->  480x800, ilace 0, cmode 40, rot 0, mir 0 flicker_filter 0
> omapdss DISPC: calc_rot(0): scrw 480, 480x800
> omapdss DISPC: offset0 0, offset1 0, row_inc 1, pix_inc 1
> omapdss DISPC: 0,0 480x800 ->  480x800
> omapdss DISPC: vid[0] attributes = c
> omapdss DISPC: fifo(0) low/high old 960/1023, new 512/960
> omapdss DISPC: dispc_enable_plane 0, 1
> omapdss DSI: starting auto update
> omapdss DSI: dsi_display_enable_te(0)
> omapdss DSI: dsi_display_set_update_mode(2)
> dsi_display_update lcd_ix=0
> omapdss DSI: dsi_display_update(0,0 480x800)
> omapdss MANAGER: dispc_setup_partial_planes 0,0 480x800
> omapdss MANAGER: configure_overlay(0)
> omapdss DISPC: dispc_setup_plane 0, pa 81430000, sw 480, 0,0, 480x800
> ->  480x800, ilace 0, cmode 40, rot 0, mir 0 flicker_filter 0
> omapdss DISPC: calc_rot(0): scrw 480, 480x800
> omapdss DISPC: offset0 0, offset1 0, row_inc 1, pix_inc 1
> omapdss DISPC: 0,0 480x800 ->  480x800
> omapdss DISPC: vid[0] attributes = ad
> omapdss DISPC: fifo(0) low/high old 512/960, new 512/960
> omapdss DISPC: dispc_enable_plane 0, 1
> omapdss MANAGER: configure_overlay(1)
> omapdss DISPC: dispc_enable_plane 1, 0
> omapdss MANAGER: configure_overlay(2)
> omapdss DISPC: dispc_enable_plane 2, 0
> omapdss MANAGER: configure_manager(0)
> omapdss DSI: dsi_vc_config_vp(0)
> omapdss DSI: dsi_vc_enable channel 0, enable 0
> omapdss DSI: dsi_vc_enable channel 0, enable 1
> omapdss DSI: dsi_update_screen_dispc(0,0 480x800)
> omapdss DSI: dsi_display_enable_te(0)
> omapdss DSI: dsi_display_set_update_mode(2)
> omapdss DSI error: framedone timeout
> omapdss DSI error: failed update 0,0 480x800
> omapdss DISPC error: timeout waiting for FRAME DONE
>
>   - Juha
>
>>
>> Archit
>>>
>>> The DSI PLL is used and configured according to the example values in
>>> the TRM (not proper for our panel but they should enable the complex
>>> IO to at least power on, right).
>>>
>>> Output form DSS DEBUG:
>>> omapdss DSI: LP_CLK_DIV 6, LP_CLK 7500000
>>> omapdss DISPC: lck = 90000000 (1)
>>> omapdss DISPC: pck = 30000000 (3)
>>> - DSI PLL -
>>> dsi pll source = dss2_alwon_fclk
>>> Fint 2000000         regn 13
>>> CLKIN4DDR 1080000000      regm 270
>>> dsi1_pll_fck 90000000        regm3 12 (on)
>>> dsi2_pll_fck 90000000        regm4 12 (on)
>>> - DSI -
>>> dsi fclk source = dsi2_pll_fclk
>>> DSI_FCLK 90000000
>>> DDR_CLK 270000000
>>> TxByteClkHS 67500000
>>> LP_CLK 7500000
>>> VP_CLK 90000000
>>> VP_PCLK 30000000
>>>
>>> As far as I can tell these values fill all the requirements set in the
>>> TRM for clock rates and their ratios.
>>>
>>> After the fail in dsi_complexio_init I dump all registers:
>>>
>>> DSI_REVISION                        00000010
>>> DSI_SYSCONFIG                       00000011
>>> DSI_SYSSTATUS                       00000001
>>> DSI_IRQSTATUS                       00080080
>>> DSI_IRQENABLE                       00000000
>>> DSI_CTRL                            00000100
>>> DSI_COMPLEXIO_CFG1                  48200321
>>> DSI_COMPLEXIO_IRQ_STATUS            00000000
>>> DSI_COMPLEXIO_IRQ_ENABLE            00000000
>>> DSI_CLK_CTRL                        a0304006
>>> DSI_TIMING1                         7fff7fff
>>> DSI_TIMING2                         7fff7fff
>>> DSI_VM_TIMING1                      00000000
>>> DSI_VM_TIMING2                      00000000
>>> DSI_VM_TIMING3                      00000000
>>> DSI_CLK_TIMING                      00000101
>>> DSI_TX_FIFO_VC_SIZE                 00000000
>>> DSI_RX_FIFO_VC_SIZE                 00000000
>>> DSI_COMPLEXIO_CFG2                  00000000
>>> DSI_RX_FIFO_VC_FULLNESS             00000000
>>> DSI_VM_TIMING4                      00000000
>>> DSI_TX_FIFO_VC_EMPTINESS            00000000
>>> DSI_VM_TIMING5                      00000000
>>> DSI_VM_TIMING6                      00000000
>>> DSI_VM_TIMING7                      00000000
>>> DSI_STOPCLK_TIMING                  00000080
>>> DSI_VC_CTRL(0)                      00000000
>>> DSI_VC_TE(0)                        00000000
>>> DSI_VC_LONG_PACKET_HEADER(0)        00000000
>>> DSI_VC_LONG_PACKET_PAYLOAD(0)       00000000
>>> DSI_VC_SHORT_PACKET_HEADER(0)       00000000
>>> DSI_VC_IRQSTATUS(0)                 00000000
>>> DSI_VC_IRQENABLE(0)                 00000000
>>> DSI_VC_CTRL(1)                      00000000
>>> DSI_VC_TE(1)                        00000000
>>> DSI_VC_LONG_PACKET_HEADER(1)        00000000
>>> DSI_VC_LONG_PACKET_PAYLOAD(1)       00000000
>>> DSI_VC_SHORT_PACKET_HEADER(1)       00000000
>>> DSI_VC_IRQSTATUS(1)                 00000000
>>> DSI_VC_IRQENABLE(1)                 00000000
>>> DSI_VC_CTRL(2)                      00000000
>>> DSI_VC_TE(2)                        00000000
>>> DSI_VC_LONG_PACKET_HEADER(2)        00000000
>>> DSI_VC_LONG_PACKET_PAYLOAD(2)       00000000
>>> DSI_VC_SHORT_PACKET_HEADER(2)       00000000
>>> DSI_VC_IRQSTATUS(2)                 00000000
>>> DSI_VC_IRQENABLE(2)                 00000000
>>> DSI_VC_CTRL(3)                      00000000
>>> DSI_VC_TE(3)                        00000000
>>> DSI_VC_LONG_PACKET_HEADER(3)        00000000
>>> DSI_VC_LONG_PACKET_PAYLOAD(3)       00000000
>>> DSI_VC_SHORT_PACKET_HEADER(3)       00000000
>>> DSI_VC_IRQSTATUS(3)                 00000000
>>> DSI_VC_IRQENABLE(3)                 00000000
>>> DSI_DSIPHY_CFG0                     1e481d3a
>>> DSI_DSIPHY_CFG1                     420a1a6a
>>> DSI_DSIPHY_CFG2                     b800001a
>>> DSI_DSIPHY_CFG5                     60000000
>>> DSI_PLL_CONTROL                     00000000
>>> DSI_PLL_STATUS                      00000383
>>> DSI_PLL_GO                          00000000
>>> DSI_PLL_CONFIGURATION1              05d90e19
>>> DSI_PLL_CONFIGURATION2              0005600e
>>>
>>> Of special interest is the DSI_COMPLEXIO_CFG1. RESET_DONE is not set,
>>> not does the PWR_STATUS match the command given. The
>>> LDO_POWER_GOOD_STATE is asserted however.
>>>
>>> The DSI is powered and all the clocks seem to be on and the DSI PLL
>>> locks. Just the complex IO will not power on. I am using a 2.6.32.9
>>> kernel so it is not the latest but I wanted to ask if someone had any
>>> idea where to look next before porting the latest onto our board.
>>>
>>> Thanks,
>>>   - Juha
>>>
>>> --
>>> Duck tape is like the force, it has a light side and a dark side and
>>> it holds the universe together.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>
>
>

