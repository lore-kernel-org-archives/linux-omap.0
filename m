From: John Faith <jfaith7@gmail.com>
Subject: Re: Enabling 3530 sys_clkout2
Date: Mon, 14 Dec 2009 14:58:42 -0800
Message-ID: <e0727e900912141458i2737b7favfe1ecc8feceafe40@mail.gmail.com>
References: <e0727e900912141230q1e98d4c3ge408101664a0c712@mail.gmail.com>
	 <alpine.DEB.2.00.0912141457110.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:55855 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757854AbZLNW6n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 17:58:43 -0500
Received: by pzk1 with SMTP id 1so2618849pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 14:58:42 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912141457110.12561@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Mon, Dec 14, 2009 at 1:59 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello John,

Hi Paul,

>
> On Mon, 14 Dec 2009, John Faith wrote:
>
>> I'm trying to enable the sys_clkout2 pin in a 2.6.29 kernel for my
>> 3530EVM-like board for the main clock line of an FPGA. =A0I've added=
 a
>> MUX_CFG_34XX entry in mux.c, set the gpio direction in my board.c
>> file, and set the rate in my driver with clk_set_parent(),
>> clk_set_rate() but I do not see any output clock when probed with a
>> scope.
>
> Sounds like either the clock is not enabled (use clk_enable() for thi=
s),
> or there is a mux problem.
>
> You might also want to make sure that you've set the parent of
> clkout2_src_ck appropriately, although you still should be able to ge=
t
> something out of it.

After 3 clk_get() for clkout2_src_ck, sys_clkout2, and func_96m_ck, I
set the parent the same as n810.c with:

 clk_set_parent(sys_clkout2_src, func96m_clk);
 clk_set_rate(sys_clkout2, 12000000);

Calling clk_enable(sys_clkout2); returns zero.


As a test, I also tried going around the clock APIs and enabling the
clock directly with by writing to the CM_CLKOUT_CTRL register, with
similar results (no output).

My mux setting is:
 MUX_CFG_34XX("SYS_CLKOUT2", 0x1E2,
        OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)


Thanks for the suggestions!
,
John
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
