From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: [PATCH] ASoC: Replace snd_soc_machine by snd_soc_card structure
 in SDP3430 machine driver
Date: Tue, 10 Feb 2009 01:57:08 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705D6175432@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705D6175398@dlee07.ent.ti.com>
 <20090210095146.63a77c83.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60730 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbZBJH5V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 02:57:21 -0500
In-Reply-To: <20090210095146.63a77c83.jarkko.nikula@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>

> On Tue, 10 Feb 2009 00:57:00 +0100
> "ext Lopez Cruz, Misael" <x0052729@ti.com> wrote:
> 
> > This patch replaces "snd_soc_machine" structure by "snd_soc_card" in 
> > SP3430 driver. This change is needed in SDP3430 driver to reflect 
> > changes introduced by "ASoC: Rename snd_soc_card to snd_soc_machine"
> > patch (875065491fba8eb13219f16c36e79a6fb4e15c68).
> > 
> > Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> > ---
> >  sound/soc/omap/sdp3430.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> Looks like you haven't subscribed to alsa-devel since I don't 
> see your patch there? You can subscribe but have mail 
> delivery disabled if you don't want to get mailing list 
> traffic to your account.

I'm sorry I used 'alsa-devel-request' instead of 'alsa-devel'. I'll resend the patch right away.

> Patch itself looks like for 2.6.29-rc since it fixes a 
> compilation error. Ack from me, compile tested on linux-omap.
> 
> Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
