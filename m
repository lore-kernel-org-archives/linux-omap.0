From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/4] omap mailbox: extend API to take a callback param
Date: Thu, 24 Jun 2010 19:52:27 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4C8912F7@dlee03.ent.ti.com>
References: <1277251896-6890-1-git-send-email-ohad@wizery.com>
 	<8F7AF80515AF0D4D93307E594F3CB40E4C890B4A@dlee03.ent.ti.com>
 <AANLkTinS1rPAEu-S-HOtslq7M1WeH3oCkPaeSh__8OIa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58800 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab0FYAwd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 20:52:33 -0400
In-Reply-To: <AANLkTinS1rPAEu-S-HOtslq7M1WeH3oCkPaeSh__8OIa@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Ohad,

> 
> On Thu, Jun 24, 2010 at 6:02 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > Looks good.
> 
> PCMIIW: from your other mail, I now understand that on OMAP4 you call
> omap_mbox_get several times to allow several concurrent mbox senders.

I don't know what PCMIIW stands for :). omap_mbox_get can be called by several concurrent mbox senders (1 sender per co-processor).

It looks like the variable mbox_configured that was added previously doesn't cover all the issues. It covers the shutdown issue with reference counting but as you mentioned that it poses an issue at startup as the RX interrupt for the second mbox instance doesn't get enabled.


> 
> If that's the case, this new API concept is a bit broken: it should
> allow several senders to call it, but will only support a single rx
> callback (probably by ignoring NULL callbacks, but that's not really
> safe).
> 
> We have two options here:
> 
> 1. do not extend omap_mbox_get to get a callback. instead, add a new
> API that explicitely sets the callback pointer.
> 
> 2. do extend omap_mbox_get to get a callback, but then employ
> something like a notifier chain of callbacks, essentially supporting
> multiple callbacks. this will allow a more flexible API, something
> that Hiroshi also wanted.

-- Even though this might not be relevant to mbox_configured issue, this looks like a nice feature to add. So this means we are going to support multiple writers to mailbox instance?

Thank you,
Best regards,
Hari
