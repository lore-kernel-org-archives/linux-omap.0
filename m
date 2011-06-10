From: Steve Calfee <stevecalfee@gmail.com>
Subject: beagleboard xm alsa in mcbsp3. 2.6.39-rc4
Date: Thu, 09 Jun 2011 19:55:21 -0700
Message-ID: <4DF18799.1040503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47321 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710Ab1FJCzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 22:55:25 -0400
Received: by pzk9 with SMTP id 9so1029883pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Jun 2011 19:55:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I have mcbsp1 working on an external codec. I moved the wires to the
mcbsp3 pins. The codec is master, using tdm mode. I use the same codec
i2s bus, and it gets the same setup (I change the dai-link stuff in my
alsa machine driver to use the other omap i2s bus for my tests). If I
pull the clk wire off the beagleboard pin, the clock from the codec
looks good. With the wire attached to the pin, I don't see the pin
wiggling. So it looks like maybe the pin is an output or something. The
frame clock looks ok while connected.

In the board-omap3beagle.c I configure all 3 mcbsp the same way:


#ifdef CONFIG_OMAP_MUX
static struct omap_board_mux board_mux[] __initdata = {
#if 1
	/* McBSP 1 slave */
	OMAP3_MUX(MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP1_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP1_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
#else
	/* McBSP 1 master */
	OMAP3_MUX(MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
	OMAP3_MUX(MCBSP1_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP1_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
#endif
#if 1
	/* McBSP 2 slave */
	OMAP3_MUX(MCBSP2_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP2_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP2_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP2_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
#else
	/* McBSP 2 master */
	OMAP3_MUX(MCBSP2_FSX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
	OMAP3_MUX(MCBSP2_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
	OMAP3_MUX(MCBSP2_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP2_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
#endif
#if 1
	/* McBSP 3 slave */
	OMAP3_MUX(MCBSP3_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP3_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP3_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP3_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
#else
	/* McBSP 3 master */
	OMAP3_MUX(MCBSP3_FSX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
	OMAP3_MUX(MCBSP3_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
	OMAP3_MUX(MCBSP3_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP3_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
#endif
	{ .reg_offset = OMAP_MUX_TERMINATOR },
};
#endif

So far I have not been able to get the codec mastered bit clock to work
on either mcbsp2 or msbsp3.

I have been trying to follow the logic in mcbsp.c and in omap-mcbsp.c in
how things get inited. I suspect there is something I have not done?

Any ideas.

Thanks, Steve
