From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 3/7] ARM: OMAP4+: PRM: remove "wkup" event
Date: Mon, 21 Jul 2014 06:17:38 -0500
Message-ID: <CAGo_u6ryytHiV1dnkPx-qFGa4ZB3KxVDrjmA+Ls5bakHVLunsQ@mail.gmail.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
	<1402025761-16831-4-git-send-email-nm@ti.com>
	<20140721104413.GT18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:51226 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbaGULRm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 07:17:42 -0400
In-Reply-To: <20140721104413.GT18374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dt list <devicetree@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jul 21, 2014 at 5:44 AM, Tony Lindgren <tony@atomide.com> wrote:
>
> Hmm so why was it added originally then?
>
> Do the PRM_IRQSTATUS line and the following line belong together
> or is it missing something?


Seems like to have been a copy paste from OMAP3 code which did have
wakeup event at bit 0.

-- 
---
Regards,
Nishanth Menon
