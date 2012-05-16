From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 17 May 2012 02:46:38 +0530
Message-ID: <CAJe_ZhebPfmLS8ur8FAnmdj37ye25HrE2QF-Qk5PVDnzmpAniQ@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	<4FB3D294.4020505@wwwdotorg.org>
	<CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
	<201205161942.20296.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38824 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756131Ab2EPVQk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 17:16:40 -0400
Received: by lahd3 with SMTP id d3so851855lah.19
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 14:16:39 -0700 (PDT)
In-Reply-To: <201205161942.20296.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 17 May 2012 01:12, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> Generic binding to provide a way to provide the client-channel map a=
nd
>> other dmac specific parameters to the dma controller driver
>>
>> DMA Model:-
>> =A0 Only the most common characteristics of a dma setup are assumed
>> in this binding.
>> Client: Some h/w controller that could request a DMA controller in
>> the system to perform data transfer on its behalf. Example SPI, MMC,
>> I2S etc.
>> DMAC: A DMA Controller instance. Example, PL330, PL08X, SDMA etc.
>>
>> =A0The assumed model of the DMAC, in this binding, has P peripheral
>> interfaces (P request signals) that could request a data transfer
>> and C physical channels that actually do the data transfers, hence,
>> at most C out of P peripherals could be served by the DMAC at any
>> point of time. Usually C :=3D P, but not always. Usually, any of the
>> physical channels could be employed by the DMAC driver to serve any
>> client.
>> =A0The DMAC driver identifies a client by its i/f number, 'peri_id'
>> on the given DMAC. For example, TX for SPI has 7th while RX_TX
>> (half-duplex) for MMC has 10th peripheral interface (request-signal)
>> on a given DMAC. Usually, any of the physical channels could be
>> employed by the DMAC driver to serve a client.
>
Btw, just to be clear... this is not _my_ setup.
The dma controller manuals might use different terms but underneath
most(if not all) dma controllers fit this model. At lease every dmac
on Samsung SoCs and ARM's PL330 and PL08x does.
In fact, I have trouble imaging some dmac not conforming to this model.=
=2E.
but then again it could be just me.


> I'm still anything but convinced by this model. Basically it's the
> exact opposite of what we do for every other subsystem (irq, pinctrl,
> regulator, gpio, ...), where the device using some infrastructure
> contains the information about who provides it, whereas here you
> move all the information into the device that provides the functional=
ity,
> and have no handle in the device using it by which the driver can
> identify it.
>
The idea was that a client shouldn't need to know/tell which dma contro=
ller
serves it or which peripheral interface of a dma controller.
I think in future third-party device IPs, like ARM's Primecell, are onl=
y gonna
get more common so it makes even more sense.


> I believe that it can work and that it solves the problem you are
> faced with at minimal complexity, but you put the burden of this
> complexity on everybody who does not have this issue, and make
> the general binding confusing and harder to read.
>
I am sorry if I gave you the wrong impression, but I didn't intend to j=
ust
scratch my personal itch. I truly believed I and Stephen reached a gene=
ric
solution i.e, as much as it could be.


> It also adds much more data to the device tree (in source and binary =
form)
> because you need to describe every device using a dma controller
> and have a label to reference it.
>
I don't see why one can't add entries to chan-map as and when more
clients appear for the DMAC ? It should be perfectly ok to specify less
than the maximum possible clients in chan-map.
Requiring labels - yes, doesn't sound very nice, but many nodes already=
 do.

> More importantly, you make it very hard to add devices in a board fil=
e
> to a dma controller that already has descriptions for some channels,
> because you cannot easily extend the chan-map unless you rewrite all =
of it.
>
I am not sure I understand the point.

> We really need something simpler than this for the common case.
> I have already made suggestions for how to make it still possible
> to cover the corner case of multiple dma engines connected to the
> same slave, which would keep the complexity local to those devices
> that actually need it.
>
Thanks $DEITY, I posted a preview. Maybe I should put it on hold.
And thank you for speaking up immediately. Really!
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
