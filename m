From: John Faith <jfaith7@gmail.com>
Subject: Re: Enabling 3530 sys_clkout2
Date: Mon, 14 Dec 2009 15:34:31 -0800
Message-ID: <e0727e900912141534g1ed3cee8pc592eae39e71353@mail.gmail.com>
References: <e0727e900912141230q1e98d4c3ge408101664a0c712@mail.gmail.com>
	 <alpine.DEB.2.00.0912141457110.12561@utopia.booyaka.com>
	 <e0727e900912141458i2737b7favfe1ecc8feceafe40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:45631 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbZLNXec convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 18:34:32 -0500
Received: by pxi4 with SMTP id 4so2164622pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 15:34:31 -0800 (PST)
In-Reply-To: <e0727e900912141458i2737b7favfe1ecc8feceafe40@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Mon, Dec 14, 2009 at 2:58 PM, John Faith <jfaith7@gmail.com> wrote:
> On Mon, Dec 14, 2009 at 1:59 PM, Paul Walmsley <paul@pwsan.com> wrote=
:
>> Hello John,
>
> Hi Paul,
>
>>
>> On Mon, 14 Dec 2009, John Faith wrote:
>>
>>> I'm trying to enable the sys_clkout2 pin in a 2.6.29 kernel for my
>>> 3530EVM-like board for the main clock line of an FPGA. =A0I've adde=
d a
>>> MUX_CFG_34XX entry in mux.c, set the gpio direction in my board.c
>>> file, and set the rate in my driver with clk_set_parent(),
>>> clk_set_rate() but I do not see any output clock when probed with a
>>> scope.
>>
>> Sounds like either the clock is not enabled (use clk_enable() for th=
is),
>> or there is a mux problem.
>>
>> You might also want to make sure that you've set the parent of
>> clkout2_src_ck appropriately, although you still should be able to g=
et
>> something out of it.
>
> After 3 clk_get() for clkout2_src_ck, sys_clkout2, and func_96m_ck, I
> set the parent the same as n810.c with:
>
> =A0clk_set_parent(sys_clkout2_src, func96m_clk);
> =A0clk_set_rate(sys_clkout2, 12000000);
>
> Calling clk_enable(sys_clkout2); returns zero.
>

To answer my own question, I was using:
  func96m_clk =3D clk_get(&dev->dev, "func_96m_ck");

, but apparently should have been using:
 func96m_clk =3D clk_get(&dev->dev, "cm_96m_fck");

which produces the expected clock output.

,
John
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
