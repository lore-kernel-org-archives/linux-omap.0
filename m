From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Thu, 18 Feb 2010 14:16:22 -0800
Message-ID: <5e088bd91002181416l33dc2fe4u8d2a09d12ea0344e@mail.gmail.com>
References: <cover.1265801967.git.david.vrabel@csr.com>
	 <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com>
	 <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com>
	 <004901cab001$6b19f6c0$544ff780@am.dhcp.ti.com>
	 <4B7C4608.5010008@csr.com>
	 <alpine.DEB.2.00.1002171254040.24812@utopia.booyaka.com>
	 <4B7D3EAE.1010908@csr.com>
	 <alpine.DEB.2.00.1002180951330.24812@utopia.booyaka.com>
	 <004001cab0c9$b208b2b0$544ff780@am.dhcp.ti.com>
	 <alpine.DEB.2.00.1002181231520.24812@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64134 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab0BRWQX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 17:16:23 -0500
In-Reply-To: <alpine.DEB.2.00.1002181231520.24812@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Madhusudhan <madhu.cr@ti.com>, David Vrabel <david.vrabel@csr.com>, r-woodruff2@ti.com, sawant@ti.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, Feb 18, 2010 at 12:21 PM, Paul Walmsley <paul@pwsan.com> wrote:

> (cc'ing Steve, Richard, Anand)

> There appear to be least seven SDIO card drivers in 2.6.34-rc7. At le=
ast
> one of these is for a TI chip - the wl1251. =A0I think some of the
> Gumstix Overo OMAP3 boards are using an SDIO-connected Marvell Libert=
as:
>
> http://www.gumstix.com/store/catalog/product_info.php?products_id=3D2=
52

That is correct, a Wi2Wi wifi module is connected via mmc2 on the
Overo Air and Fire products.

Data rates are pretty low with the existing OMAP SDIO driver.   Any
chance this patch would improve that situation?

Just added applying the patch and retesting data rates to my "to do" li=
st :-)

Steve

> David is probably testing with a Bluetooth card - maybe he can commen=
t
> further.
>
>> And at least I don't see a way I can test any of these features myse=
lf.
>
> Could you clarify?
>
>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
