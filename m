From: Nishanth Menon <nm@ti.com>
Subject: Re: need help to configure IRQ on gpio 139 pandaboard using device
 tree
Date: Thu, 12 Dec 2013 10:15:25 -0600
Message-ID: <52A9E11D.6050403@ti.com>
References: <52A8768C.5070103@st.com> <CAGo_u6p9D_rkzte_nxy9EsNyW1ouDPt2eP4zhrYBRjmd8+VHUA@mail.gmail.com> <52A89206.8080605@st.com> <52A8A1A1.9090104@ti.com> <52A9BC8E.9090007@st.com> <52A9C7B6.3020905@st.com> <52A9CCEB.3050308@ti.com> <52A9D0D2.7080907@st.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:38578 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab3LLQP3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 11:15:29 -0500
Received: by mail-oa0-f51.google.com with SMTP id i7so663636oag.38
        for <linux-omap@vger.kernel.org>; Thu, 12 Dec 2013 08:15:27 -0800 (PST)
In-Reply-To: <52A9D0D2.7080907@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 12/12/2013 09:05 AM, Denis CIOCCA wrote:
>> why is mcspi1 your interrupt parent when you did a padconf for GPIO?
>> you want GPIO136, so you need the right gpio block as the interrupt
>> parent and map interrupts in the correct map.
>> see [1] for an example (omap2).
> Oh my god! Now I've understand how device tree works...I'm sorry
> Nishanth but the dt it's new for me...ok I'm using gpio5 and now it works!
>
> +interrupt-parent = <&gpio5>;
> +       interrupts = <8 IRQ_TYPE_LEVEL_HIGH>; /* gpio line 136 */
>
> Thank you very much for your patience...;)

glad to hear it worked, yeah, device tree is a little different, but 
logical in it's own way.

Regards,
Nishanth Menon

