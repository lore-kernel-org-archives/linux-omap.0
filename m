From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Padconf not working on pm_defconfig?
Date: Mon, 14 Dec 2009 22:36:44 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C86409@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4EFC@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E739404372AAB54@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030ADD4F0F@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030ADD4F23@dbde02.ent.ti.com>,<87fx7dcx8k.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44184 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757988AbZLNRIt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 12:08:49 -0500
In-Reply-To: <87fx7dcx8k.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Peter De Schrijver <peter.de-schrijver@nokia.com>

Kevin Hilman wroteL
> >
> > Found it - I remember that these lines are muxed with ETK signals
> > and with the hwdebug signals.
> >
> > So I looked at the debobs driver - and that's the culprit!
> > (Cc-ing the author of that driver)
> >
> > How should this be handled? IMO, this driver has should use the
> > MUX framework for changing the mux modes.
> >
> > What say?
> 
> Yes, the debobs driver needs to be updated to use the MUX API.
> 
> But even with that, AFAICT, the new mux API will still allow
> the last caller to "win" as there is no request/free API
> to get pins.
> 

At least the debug prints would have pointed me to this driver.

Okay, I'll try and cook something up for updating the debobs driver.

- Anand
