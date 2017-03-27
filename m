From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Mon, 27 Mar 2017 07:30:50 -0700
Message-ID: <20170327143049.GG10760@atomide.com>
References: <20170315140801.97230-1-moreno.bartalucci@tecnorama.it>
 <20170324185836.GC19814@uda0271908>
 <2d10809f-d482-ffa9-30b7-8785e94ab102@gmail.com>
 <00882633-3F61-4010-A4D2-D04473282B10@tecnorama.it>
 <20170327131701.GA12674@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170327131701.GA12674@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, Moreno Bartalucci <moreno.bartalucci@tecnorama.it>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu@ti.com> [170327 06:22]:
> On Mon, Mar 27, 2017 at 02:53:27PM +0200, Moreno Bartalucci wrote:
> > > Il giorno 25 mar 2017, alle ore 08:21, Lars Melin <larsm17@gmail.com> ha scritto:
> > > 
> > >> 
> > >> The usb device has been disconnected, why it still cares about VBUS
> > >> power?
> > > 
> > > Morphing devices (3G dongles, wifi dongles, some printers) boots up in install mode, usually only as a virtual cd-rom containing Windows drivers and software.
> > > [...]
> > > why a host only configured port should cut the VBUS supply, it could be always on right?
> > > 
> > 
> > Yes, that’s exactly the problem I tried to solve with this patch.
> 
> Yeah, the problem is clear to me now.

Ah so it's with the state changing devices.

> > I have to add that the problem was not there with kernels up to
> > 4.8.17, I started to see it with 4.9 and up.
> > 
> > By git-bisecting kernel sources, it appears this behaviour has been
> > introduced by this commit:
> > 
> > 2f3fd2c5bde1f94513c3dc311ae64494085ec371
> 
> It seems this patch changes how OTG_STATE_A_WAIT_VRISE and
> OTG_STATE_A_WAIT_BCON are used.
> > 
> > I also agree that, in my opinion, a host only port should never remove
> > the VBUS supply, as it happens on all the PCs (linux+windows+mac) that
> > I tested until now.
> 
> True. It is just that the musb driver handles both dual-role and
> host-only mode.

Maybe the other way to fix it would be to keep VBUS on longer when
checking for connected devices. Maybe we now recheck based on the
poll_timeout too early and then nothing is found.

> > I saw this problem on a beaglebone black. Of course I’m available to
> > do all the tests that you might suggest me to help you better
> > understand the issue.
> 
> Thanks for the offer. Please let me look at the problem first, I have a
> modem to test.
> It is not clear why the original driver clears VBUS in this place, so I
> have to ensure your patch is the correct change.

I wonder if the following test patch allows the mode changing
devices to been properly found? Of course it's just for testing,
and scanning for devices takes now 5 seconds.. But it might
provide clues why musb thinks no devices are connected and we
cut VBUS.

Regards,

Tony

8< ----------------------
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -991,7 +991,7 @@ static const struct dsps_musb_wrapper am33xx_driver_data = {
 	.rxep_shift		= 16,
 	.rxep_mask		= 0xfffe,
 	.rxep_bitmap		= (0xfffe << 16),
-	.poll_timeout		= 2000, /* ms */
+	.poll_timeout		= 5000, /* ms */
 };
 
 static const struct of_device_id musb_dsps_of_match[] = {
