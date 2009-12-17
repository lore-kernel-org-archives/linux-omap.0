From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98 breaks omapfb (old
	non-dss2)
Date: Thu, 17 Dec 2009 17:51:32 +0300
Message-ID: <48239d390912170651g1dab3c37ycbbbd2df1f722f3b@mail.gmail.com>
References: <48239d390912150158xdf2999dr6b43f21c64456002@mail.gmail.com>
	 <1260890578.6017.11.camel@tubuntu.research.nokia.com>
	 <48239d390912150801y70da9d46k637c01d8da3a5595@mail.gmail.com>
	 <1260962480.15771.1.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:27294 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZLQOve (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 09:51:34 -0500
Received: by ey-out-2122.google.com with SMTP id d26so549342eyd.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Dec 2009 06:51:33 -0800 (PST)
In-Reply-To: <1260962480.15771.1.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Dec 16, 2009 at 2:21 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Tue, 2009-12-15 at 17:01 +0100, ext Sergey Lapin wrote:
>> On Tue, Dec 15, 2009 at 6:22 PM, Tomi Valkeinen
>> <tomi.valkeinen@nokia.com> wrote:
>> > Hi,
>> >
>> > On Tue, 2009-12-15 at 10:58 +0100, ext Sergey Lapin wrote:
>> >> dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98
>> >> OMAP: OMAPFB: add omapdss device
>> >>
>> >>     The upcoming new display subsystem driver is divided to two devices,
>> >>     omapdss and omapfb, of which omapdss handles the actual hardware.
>> >>
>> >>     This patch adds a dummy omapdss platform device for the current omapfb
>> >>     driver, which is then used to get the clocks. This will make it possible
>> >>     for the current and the new display drivers to co-exist.
>> >>
>> >>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>> >>     Acked-by: Tony Lindgren <tony@atomide.com>
>> >>
>> >> breaks old omapfb.
>> >
>> > I didn't look at this further, but I quickly tested with OMAP3 SDP
>> > board, reverting the patch that makes SDP use DSS2, and it seems to work
>> > fine with the old omapfb.
>
> rfbi.c was still using omapfb device to get the clocks. Can you try this
> patch?
>
>
> >From 33b78006fb0387e21d5f780338d821621ecad929 Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Date: Wed, 16 Dec 2009 13:18:07 +0200
> Subject: [PATCH] OMAP: OMAPFB: fix clk_get for RFBI
>
> omapfb platform device was still used to get clocks inside rfbi.c
If you add #include <linux/platform_device.h> to this patch,
then problem is fixed.

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Tested-by: Sergey Lapin <slapin@ossfans.org>

> ---
>  drivers/video/omap/dispc.c  |    2 +-
>  drivers/video/omap/omapfb.h |    2 ++
>  drivers/video/omap/rfbi.c   |    4 ++--
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
