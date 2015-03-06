From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC 3/6] drm/tilcdc: Add support for external compontised
 DRM encoder
Date: Fri, 6 Mar 2015 12:21:42 +0200
Message-ID: <54F97FB6.3060103@ti.com>
References: <cover.1424961754.git.jsarha@ti.com> <92792bb4f64fb1b7f26e687ec159d870d0e7a81a.1424961754.git.jsarha@ti.com> <20150302160135.GA29584@n2100.arm.linux.org.uk> <54F96657.10200@ti.com> <20150306095848.GH29584@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53982 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932369AbbCFKWN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Mar 2015 05:22:13 -0500
In-Reply-To: <20150306095848.GH29584@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, tomi.valkeinen@ti.com, detheridge@ti.com, moinejf@free.fr, laurent.pinchart@ideasonboard.com

On 03/06/15 11:58, Russell King - ARM Linux wrote:
> On Fri, Mar 06, 2015 at 10:33:27AM +0200, Jyri Sarha wrote:
>> Would it be Ok to add a check that master->ops->add_components is defined,
>> before calling it in find_componets() (drivers/base/component.c:120) and
>> return 0 if it is not?
>
> No:
>
> http://ftp.arm.linux.org.uk/cgit/linux-arm.git/commit/?h=8c4e8764a7e3
>
> also:
>
> http://ftp.arm.linux.org.uk/cgit/linux-arm.git/log/?h=11eda5aaf41e
>
> is what's planned to be merged when I can get a round tuit, and people
> stop using the old methods.
>

Ok, but could it still be allowed to add a master without any components 
(match == NULL)?

Or do I have to handle the configurations without any components separately?

Best regards,
Jyri
