From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 3/9] ARM: at91: add at91sam9g20ek boards dt support
Date: Thu, 12 Apr 2012 12:14:24 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317C7D68@DBDE01.ent.ti.com>
References: <20120411153515.GK16641@game.jcrosoft.org>
 <1334160079-30831-3-git-send-email-plagnioj@jcrosoft.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C7B88@DBDE01.ent.ti.com>
 <20120412114559.GM16641@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45490 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757971Ab2DLMOi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 08:14:38 -0400
In-Reply-To: <20120412114559.GM16641@game.jcrosoft.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@maxim.org.za" <linux@maxim.org.za>, "nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Jean,

On Thu, Apr 12, 2012 at 17:15:59, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > If ATMEL is also going driver way, then probably our voice together may be
> > heard and hopefully it will expedite the matter.
> I'm going to add it too  my idea was to create something similiar as the
> pintrl
> you register the ddifferent bank supported buy the SoC and then the driver
> request the bank for the dev_name
> 
> at soc level you will set the default timings and then the drvier may
> manipulate them
> 
> I already update the API of sam9_smc to abstract the access to the register.

Is SMC code being converted to driver ?

Regards
Afzal
