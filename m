From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [GIT PULL] OMAP DSS fixes for 3.2-rc
Date: Wed, 23 Nov 2011 07:15:59 +0000
Message-ID: <4ECC9DAF.3000005@gmx.de>
References: <1321604174.1814.41.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:37195 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753334Ab1KWHQD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 02:16:03 -0500
In-Reply-To: <1321604174.1814.41.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap mailing list <linux-omap@vger.kernel.org>

Hi Tomi,

On 11/18/2011 08:16 AM, Tomi Valkeinen wrote:
> Hi Florian,
> 
> Here are a few OMAP display subsystem fixes for 3.2-rc.
> 
> One for the old omapfb, which was missing include module.h, and two for
> the omapdss fixing issues related to HDMI.

Pulled, but...

> The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:
> 
>   Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)

...could you please try to base on something that is already in my tree, perhaps
just add patches on top of the last pull request you sent me. If you need
something more recent, that is okay, but don't force me to needlessly update my
tree.


Thanks,

Florian Tobias Schandinat

> 
> are available in the git repository at:
>   git://gitorious.org/linux-omap-dss2/linux.git for-3.2-rc
> 
> Tomi Valkeinen (3):
>       OMAPDSS: HDMI: fix returned HDMI pixel clock
>       OMAPFB: fix compilation warnings due to missing include
>       OMAPDSS: DISPC: skip scaling calculations when not scaling
> 
>  drivers/video/omap/dispc.c      |    1 +
>  drivers/video/omap2/dss/dispc.c |   11 +++++------
>  drivers/video/omap2/dss/hdmi.c  |    2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 

