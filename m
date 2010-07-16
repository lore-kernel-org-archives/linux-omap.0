From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Omap3 omap3_clk_lock_dpll5() problem
Date: Fri, 16 Jul 2010 18:14:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C910@dbde02.ent.ti.com>
References: <AANLkTinHudaXyhk3qc1sFydzZaGs3PZKW6DObw_acxOc@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C8DE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42001 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965339Ab0GPMpD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jul 2010 08:45:03 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C8DE@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Arno Steffen <arno.steffen@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Gadiyar, Anand wrote:
> Arno Steffen wrote:
> > 
> > I do have some messages while booting a 2.6.33 kernel:
> > 
> > What does this mean? How can I get rid of it?
> > What is omap3_clk_lock_dpll5()  doing and what if I comment it out? I
> > guess it make some sense ;)
> > 
> 
> Not sure why you have this issue - I'll have to dig a bit, or maybe other
> people can comment. But I can tell  you what this function is for.
> 

Looking at the 2.6.33 code, I see the WARN_ON comes from this code fragment:


                /* No freqsel on OMAP4 */
                if (!cpu_is_omap44xx()) {
                        freqsel = _omap3_dpll_compute_freqsel(clk,
                                                dd->last_rounded_n);
                        if (!freqsel)
                                WARN_ON(1);
                }

So, _omap3_dpll_compute_freqsel() returned 0.

Can you send me a kernel log with the keyword "debug" added to the bootargs?

Thanks,
Anand
