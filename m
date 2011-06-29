From: Silesh C V <silesh@ti.com>
Subject: Re: [PATCH] OMAP: HSMMC: Fix GPIO muxing
Date: Wed, 29 Jun 2011 10:26:38 +0900
Message-ID: <BANLkTin19ZDH97zXsDPgfQzX8bjxp=Hwjg@mail.gmail.com>
References: <1309250759-18472-1-git-send-email-silesh@ti.com>
	<4E09DC13.3010304@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47972 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645Ab1F2B0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 21:26:39 -0400
Received: by iwn6 with SMTP id 6so633405iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 18:26:38 -0700 (PDT)
In-Reply-To: <4E09DC13.3010304@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, kishore.kadiyala@ti.com, balajitk@ti.com, linux-arm-kernel@lists.infradead.org

Hi Igor,

On Tue, Jun 28, 2011 at 10:50 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Hi Silesh,
>
>
> IMHO, you should not separate the patches
> (this one and OMAP: 4430SDP: Register the card detect GPIO properly),
> because the 4430sdp fix should come before or together with this patch,
> otherwise 4430sdp will be broken, once this patch is applied.

4430SDP is already broken because it requests/configures GPIO 0. But
as you said if this patch goes before the SDP fix, the driver will do
Muxing of the pad (as this pad fixes that for GPIO 0)also. Thanks for
the suggestion.

>
> You can either make it a one patch or make it a single properly numbered series.
>

I will send it as a series.

Regards,
Silesh
