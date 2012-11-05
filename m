From: Rob Clark <rob@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Mon, 5 Nov 2012 08:21:53 -0600
Message-ID: <5097CB81.7050204@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com> <5090D28E.6050703@ti.com> <50939B84.6090602@ti.com> <5093A3FB.1060806@ti.com> <5093A530.5050302@ti.com> <5093A9E8.70106@ti.com> <5093AE79.9010603@ti.com> <5093B4F3.1000703@ti.com> <50977EEF.3040403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58817 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab2KEUVy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 15:21:54 -0500
In-Reply-To: <50977EEF.3040403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On 11/05/2012 02:55 AM, Tomi Valkeinen wrote:
>>> But even then, choosing the manager is not easy, as whoever chooses the
>>> >>manager needs to observe all the possible displays used at the same
>>> >>time...
>> >
>> >Right. I was wondering if omapfb/omapdrm could understand the 'all
>> >possible displays information' better compared to a panel's probe.
>> >
>> >Even omapdrm/omafb can't be perfect because we could insert a panel
>> >driver module at any time, and omapfb/omapdrm may miss that out.
> True, omapdrm/fb may have a better idea. It's still unclear though.
> Currently we have quite strict order in the sequence the modules need to
> be loaded, which is quite bad and causes issues. We should make things
> more dynamic, so that the initialization of the drivers could happen
> more freely.
>
> But that creates more problems: when booting up, omapfb starts. But
> omapfb can't know if all the panel drivers have already been loaded.
> omapfb may see that DVI is the default display, but what should it do if
> DVI doesn't have a driver yet? It could wait, but perhaps the driver for
> DVI will never even be loaded.

The encoder which is connected to the crtc (manager) is picked by 
combination of encoder->possible_crtcs bitmask and 
connector->best_encoder().  We could keep things limited so that the 
association of crtc to encoder (manager to output, roughly) never 
changes, but this isn't really the right thing to do.  It is better that 
the dssdev not rely on knowing the manager it is attached to at probe 
time, but instead grab resources more dynamically.

Also, at the moment we don't really have any notification to userspace 
about new encoders/connectors showing up (or conversely, being 
removed).  Only about existing connectors being plugged/unplugged.  The 
closest analogy is perhaps the USB display devices, but even there it is 
only the entire drm device that is plugged/unplugged.  And TBH I don't 
really see the point in supporting panel drivers being dynamically 
loaded.  It isn't like someone is dynamically soldering on a new display 
connector to some board that is running.  I think omapfb or omapdrm 
probe should trigger registering the compiled-in panel drivers, so that 
it can be sure that the dssdev's pop up before it goes and creates drm 
connector objects.  Currently we have to hack around this in omapdrm 
with late_initcall() to ensure the panel drivers are probed first, but 
that is an ugly hack that I'd like to get rid of.

BR,
-R



