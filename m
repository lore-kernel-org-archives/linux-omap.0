From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/2] ARM: DRA7: hwmod: fix gpmc hwmod
Date: Wed, 10 Jun 2015 15:44:01 +0300
Message-ID: <20150610154401.4d521405@rockdesk>
References: <1433239373-14653-1-git-send-email-rogerq@ti.com>
	<1433239373-14653-2-git-send-email-rogerq@ti.com>
	<alpine.DEB.2.02.1506022134480.14902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51664 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933433AbbFJMoL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Jun 2015 08:44:11 -0400
In-Reply-To: <alpine.DEB.2.02.1506022134480.14902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, nm@ti.com, j-keerthy@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org

Paul,

On Tue, 2 Jun 2015 21:34:58 +0000
Paul Walmsley <paul@pwsan.com> wrote:

> On Tue, 2 Jun 2015, Roger Quadros wrote:
> 
> > GPMC smart idle is not really broken but it does not support
> > smart idle with wakeup.
> > 
> > Fixes: 556708fe8718 ("ARM: OMAP: DRA7: hwmod: Make gpmc software supervised as the smart idle is broken")
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> Thanks, queued for v4.2-rc fixes.

you might want to take v2 of the patch [1] or did you fix
the conflict yourself?

cheers,
-roger

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/126730
