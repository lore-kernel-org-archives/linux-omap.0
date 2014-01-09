From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: RE: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Thu, 09 Jan 2014 09:34:59 +0200
Message-ID: <52CE5123.9050702@gmail.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com> <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com> <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com> <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:35587 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbaAIHf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jan 2014 02:35:27 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


On 09.01.2014 07:06, Hiremath, Vaibhav wrote:
> Tomi,
>
> I am seeing underflow issue on AM43x device if I use omapfb_vram argument.
> Did you see this on OMAP?
>
> I am using "omapfb_vram=10M@0xA0000000", and I believe it is correct way of usage.
>
> Thanks,
> Vaibhav
>

AFAIK underflow interrupts could come from badly calculated DSS core 
clock or bad HW resizer setup and should be unrelated to the memory 
allocation. It might be something similar to the problem I have on N900 
- see https://lkml.org/lkml/2014/1/6/173

Is it possible to upload the video you have problems with, so me to test 
it on N900? So far I didn't see any underflow issues on it (N900 is 
OMAP3, in case you're not aware), no matter the resolution of the videos 
I played(up to 720p), however I didn't test the part that allocates the 
memory on a pre-defined address. Though I don't think that should matter.

Ivo
