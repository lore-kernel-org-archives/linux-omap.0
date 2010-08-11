From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH] omap4: fb: Adds missing display update call when panning
Date: Wed, 11 Aug 2010 15:44:40 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C65D7394@dbde02.ent.ti.com>
References: <1279197422-23662-1-git-send-email-mayur@ti.com>
 <1280130435.2427.3.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52295 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758131Ab0HKKOu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 06:14:50 -0400
In-Reply-To: <1280130435.2427.3.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Diaz Prado, Gustavo" <gusdp@ti.com>

Hi Tomi,

Could you please provide me info on how to update the screen from user's space incase of manual update mode?

-Thanks,
Mayuresh

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Monday, July 26, 2010 1:17 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org; Diaz Prado, Gustavo
> Subject: Re: [PATCH] omap4: fb: Adds missing display update call when
> panning
> 
> Hi,
> 
> On Thu, 2010-07-15 at 14:37 +0200, ext Mayuresh Janorkar wrote:
> > From: Gustavo Diaz Prado <x0083741@ti.com>
> >
> > Adds the missing display update call when panning, this
> > is needed for the DSI panel when the auto-update feature is
> > not enabled.
> 
> The omapfb driver is not meant to make updates automatically, except on
> a few special cases (currently on initialization and when unblanking).
> It's the user space's responsibility to update the screen.
> 
> The reason for this should be obvious if you think of a use case where
> you have, say, all 3 overlays on the LCD, and you want to pan all of
> them.
> 
>  Tomi
> 

