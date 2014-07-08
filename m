From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH/RESEND 0/9] drm: tilcdc driver fixes
Date: Tue, 8 Jul 2014 12:03:30 +0200
Message-ID: <20140708100330.GU17271@phenom.ffwll.local>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <53ADEB73.8090301@ti.com>
 <CAF6AEGvp+A7eKWXf8uBoqXHb0Dtnt_Wz_dgFZ7Ua=UaD7yKBDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:56310 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbaGHKDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 06:03:21 -0400
Received: by mail-wg0-f48.google.com with SMTP id x12so758175wgg.31
        for <linux-omap@vger.kernel.org>; Tue, 08 Jul 2014 03:03:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF6AEGvp+A7eKWXf8uBoqXHb0Dtnt_Wz_dgFZ7Ua=UaD7yKBDw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Darren Etheridge <detheridge@ti.com>, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Russell King <linux@arm.linux.org.uk>, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>, Daniel Mack <zonque@gmail.com>

On Sat, Jun 28, 2014 at 06:51:15AM -0400, Rob Clark wrote:
> On Fri, Jun 27, 2014 at 6:08 PM, Darren Etheridge <detheridge@ti.com>=
 wrote:
> > Guido,
> >
> >
> > On 06/17/2014 09:17 AM, Guido Mart=EDnez wrote:
> >>
> >> The tilcdc driver could be compiled as a module, but was severely =
broken
> >> and could not be used as such. This patchset attempts to fix the i=
ssues
> >> preventing a proper load/unload of the module.
> >>
> >> Issues included dangling sysfs nodes, dangling devices, memory lea=
ks and
> >> a double kfree.
> >>
> >> It now seems to be working ok. We have tested this by loading and
> >> unloading the driver repeteadly, with both panel and slave connect=
ors
> >> and found no flaws.
> >>
> >> There is still one warning left on tilcdc_crtc_destroy, caused by
> >> destroying the connector while still in an ON status. We don't kno=
w why
> >> this happens or why it's an issue, so we did not fix it.
> >>
> >
> > Yes I see what you mean, it triggers the WARN_ON in tilcdc_crtc_des=
troy
> > because DRM_MODE_DPMS_ON is still set.  This WARN_ON does make some=
 sense
> > because DPMS_OFF would have the effect of turning off clocks and pu=
tting the
> > monitor to sleep which seems logical considering we have torn down =
the
> > display.  Adding a tilcdc_crtc_dpms(DPMS_OFF) right before the WARN=
_ON
> > confirms this, but it seems strange that this hasn't happened autom=
atically
> > (+ Russell doesn't need to do it in his Armada driver) - so I suspe=
ct there
> > is a better way.
>=20
> tbh, I'm not entirely sure offhand why drm_mode_config_cleanup()
> doesn't remove the fb's first (which should have the effect of
> shutting down any lit crtc/encoder/connector)..  that would seem like
> the sensible way to shut down..

All userspace fbs should be cleared already before going into the drive=
r
unload. Which only leaves you with driver internal fbs (usually just on=
e
for fbdev emulation). It's the driver's job to clean that up explicitly=
=2E
Then you can call mode_config_cleanup and the WARN_ON in there is a rea=
lly
nice space leak check.

If we'd unconditionally clean up all fbs we'd have trouble with
driver-private embedded fbs and their refcounting and would loose the
space leak check.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
