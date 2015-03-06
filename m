From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 3/6] drm/tilcdc: Add support for external compontised
 DRM encoder
Date: Fri, 6 Mar 2015 10:35:16 +0000
Message-ID: <20150306103516.GJ29584@n2100.arm.linux.org.uk>
References: <cover.1424961754.git.jsarha@ti.com>
 <92792bb4f64fb1b7f26e687ec159d870d0e7a81a.1424961754.git.jsarha@ti.com>
 <20150302160135.GA29584@n2100.arm.linux.org.uk>
 <54F96657.10200@ti.com>
 <20150306095848.GH29584@n2100.arm.linux.org.uk>
 <54F97FB6.3060103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:54431 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932459AbbCFKf0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 05:35:26 -0500
Content-Disposition: inline
In-Reply-To: <54F97FB6.3060103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, tomi.valkeinen@ti.com, detheridge@ti.com, moinejf@free.fr, laurent.pinchart@ideasonboard.com

On Fri, Mar 06, 2015 at 12:21:42PM +0200, Jyri Sarha wrote:
> On 03/06/15 11:58, Russell King - ARM Linux wrote:
> >On Fri, Mar 06, 2015 at 10:33:27AM +0200, Jyri Sarha wrote:
> >>Would it be Ok to add a check that master->ops->add_components is defined,
> >>before calling it in find_componets() (drivers/base/component.c:120) and
> >>return 0 if it is not?
> >
> >No:
> >
> >http://ftp.arm.linux.org.uk/cgit/linux-arm.git/commit/?h=8c4e8764a7e3
> >
> >also:
> >
> >http://ftp.arm.linux.org.uk/cgit/linux-arm.git/log/?h=11eda5aaf41e
> >
> >is what's planned to be merged when I can get a round tuit, and people
> >stop using the old methods.
> >
> 
> Ok, but could it still be allowed to add a master without any components
> (match == NULL)?
> 
> Or do I have to handle the configurations without any components separately?

That's not a decision I want to make in my current state.  Give me a
couple of week or two and re-ping me.

http://archive.arm.linux.org.uk/lurker/message/20150306.102749.fcabd2bf.en.html

(and the reason becomes self-evident when you realise that message did
not go to the right list on Tuesday evening when it was meant to.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
