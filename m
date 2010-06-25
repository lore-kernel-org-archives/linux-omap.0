From: Neshama Parhoti <pneshama@gmail.com>
Subject: Re: ZOOM2 doesn't boot on upstream kernel
Date: Fri, 25 Jun 2010 17:28:30 +0300
Message-ID: <AANLkTinjVP96NIUpL_UD1IWkqo3MeUPrYh_8nIEfr_n_@mail.gmail.com>
References: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030DED31F3@dbde02.ent.ti.com>
	<AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com>
	<20100625151538.755f576f@xora-desktop.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32968 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075Ab0FYO2c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 10:28:32 -0400
Received: by bwz7 with SMTP id 7so732219bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 07:28:30 -0700 (PDT)
In-Reply-To: <20100625151538.755f576f@xora-desktop.xora.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Graeme Gregory <dp@xora.org.uk>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Jun 25, 2010 at 5:15 PM, Graeme Gregory <dp@xora.org.uk> wrote:
> Its ttyS0 if the omap serial driver is compiled in. The omap driver
> takes the ports instead of the 8250 driver.

thank you, now it makes sense !

>
> Graeme
>
