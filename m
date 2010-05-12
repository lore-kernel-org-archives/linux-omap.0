From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Wed, 12 May 2010 01:20:47 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E08F7BD@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
 <20100421065550.GL4364@core.coreip.homeip.net>
 <27F9C60D11D683428E133F85D2BB4A53043DFD5320@dlee03.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A53043DFD5323@dlee03.ent.ti.com>
 <20100511044156.GA21299@core.coreip.homeip.net>
 <27F9C60D11D683428E133F85D2BB4A53043E08F7B6@dlee03.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5455792@dbde02.ent.ti.com>
 <20100512060305.GA13273@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40747 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693Ab0ELGUt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 02:20:49 -0400
In-Reply-To: <20100512060305.GA13273@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > Sorry for jumping into the comments late. Thought this was sorted out. Key
> scanning
> > and debounce timeouts etc still there. Having all these things in ISR itself
> isn't good
> > idea.
> >
> > Dmitry,
> > Don't you think its optimal to push the key-scanning and debounce timeout
> code
> > part of bottom half ??
> >
> 
> If you need debounce then you need to fire a timer and keep doing this
> until interrupt (or key state) settles. It really depends on the device.

Controller includes a debouncing feature... 
