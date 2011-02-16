From: Daniel Morsing <daniel.morsing@gmail.com>
Subject: Re: [PATCH 0/2] Add recommended bpp for omap dss2 generic dpi
 panels
Date: Wed, 16 Feb 2011 15:06:33 +0100
Message-ID: <1297865193.8777.8.camel@morsing>
References: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com>
	 <1297861914.988.1.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61999 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab1BPOGC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 09:06:02 -0500
In-Reply-To: <1297861914.988.1.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Bryan Wu <bryan.wu@canonical.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi

On Wed, 2011-02-16 at 15:11 +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On Sat, 2011-02-12 at 11:02 -0600, Daniel Morsing wrote:
> > The panel added is the 4.3 inch display that is sold with the
> > Devkit8000.
> 
> Hmm. Devkit8000's panel is connected with 24 datalines, according to the
> board file. Why do you want to use 16 bpp format for that?
> 
>  Tomi
> 

Running the panel at 24 bpp or specifying 16 datalines causes color
distortion.

The only way I've been able to run the panel without color distortion,
is with 24 datalines and 16 bpp.

I'm not well versed in displays, so I might be making a mistake
somewhere. The BSP for the devkit8000 doesn't include a datasheet for
the panel, so I can't look into what's causing this weirdness.

Regards,
Daniel Morsing

