From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/6] OMAP: board file changes for DSS2 porting
Date: Mon, 09 May 2011 20:01:39 +0300
Message-ID: <1304960499.2215.49.camel@deskari>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35450 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751837Ab1EIRBn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 13:01:43 -0400
Received: by mail-ey0-f175.google.com with SMTP id 27so1599834eye.6
        for <linux-omap@vger.kernel.org>; Mon, 09 May 2011 10:01:42 -0700 (PDT)
In-Reply-To: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

On Mon, 2011-05-09 at 10:36 +0300, Tomi Valkeinen wrote:
> Hi Tony,
> 
> I posted last week a patch set porting most of the old omapfb OMAP2/3 drivers
> to DSS2 (http://marc.info/?l=linux-fbdev&m=130451207802788&w=2). That patch set
> contains changes to both the drivers and the board files, and it seems there is
> already a minor conflict in them.
> 
> So I think it's simpler to divide the set into two parts, this one, which
> contains the board file changes, and another containing the driver changes.
> Merging will probably go easier if you can take this patch set via linux-omap,
> and I'll take the driver changes via dss2 tree.
> 
> Applying this set without the driver changes will obviously disable the
> displays of the affected boards until the drivers are also merged.

Tony, I updated the patches, adding one Ack and cleaning up the 2430sdp
a bit. The patches can be found from

git://gitorious.org/linux-omap-dss2/linux.git board-changes-for-tony

should you decide to pull them.

>  Tomi
> 
> 
> Tomi Valkeinen (6):
>   OMAP: RX51: Remove unused old omapfb stuff
>   OMAP: omap3touchbook: Remove unused lcd stuff
>   OMAP: 2420SDP: Port the display driver to new DSS2
>   OMAP: LDP: Port the display driver to new DSS2
>   OMAP: H4: Port the display driver to new DSS2
>   OMAP: Apollon: Port the display driver to new DSS2
> 
>  arch/arm/mach-omap2/board-2430sdp.c        |   84 +++++++++++++++++++++++-----
>  arch/arm/mach-omap2/board-apollon.c        |   34 +++++++----
>  arch/arm/mach-omap2/board-h4.c             |   41 ++++++++-----
>  arch/arm/mach-omap2/board-ldp.c            |   73 +++++++++++++++++++++---
>  arch/arm/mach-omap2/board-omap3touchbook.c |   18 ------
>  arch/arm/mach-omap2/board-rx51.c           |   25 --------
>  6 files changed, 180 insertions(+), 95 deletions(-)
> 


