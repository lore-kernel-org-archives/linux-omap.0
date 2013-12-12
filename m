From: Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: need help to configure IRQ on gpio 139 pandaboard using device
 tree
Date: Thu, 12 Dec 2013 16:05:54 +0100
Message-ID: <52A9D0D2.7080907@st.com>
References: <52A8768C.5070103@st.com>
 <CAGo_u6p9D_rkzte_nxy9EsNyW1ouDPt2eP4zhrYBRjmd8+VHUA@mail.gmail.com>
 <52A89206.8080605@st.com> <52A8A1A1.9090104@ti.com>
 <52A9BC8E.9090007@st.com> <52A9C7B6.3020905@st.com> <52A9CCEB.3050308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:42249 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300Ab3LLPGN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 10:06:13 -0500
In-Reply-To: <52A9CCEB.3050308@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> why is mcspi1 your interrupt parent when you did a padconf for GPIO?
> you want GPIO136, so you need the right gpio block as the interrupt
> parent and map interrupts in the correct map.
> see [1] for an example (omap2).
Oh my god! Now I've understand how device tree works...I'm sorry 
Nishanth but the dt it's new for me...ok I'm using gpio5 and now it works!

+interrupt-parent = <&gpio5>;
+       interrupts = <8 IRQ_TYPE_LEVEL_HIGH>; /* gpio line 136 */

Thank you very much for your patience...;)

BR,
Denis