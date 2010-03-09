From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH V4] OMAP: DSS: Add NEC NL8048HL11-01B display panel
Date: Tue, 9 Mar 2010 10:59:41 -0600
Message-ID: <A24693684029E5489D1D202277BE894453E4D7D6@dlee02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026EE415C0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48882 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab0CIQ7q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 11:59:46 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026EE415C0@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Y, Kishore" <kishore.y@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kishore,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Y, Kishore
> Sent: Saturday, March 06, 2010 8:17 AM
> To: Tomi Valkeinen
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH V4] OMAP: DSS: Add NEC NL8048HL11-01B display panel
> 
> From: Erik Gilling <konkers@android.com>
> Date: Wed, 2 Dec 2009 22:05:34 +0530
> Subject: [PATCH] OMAP: DSS: Add NEC NL8048HL11-01B display panel
> 
> NEC WVGA LCD NL8048HL11-01B support has been added.

I think this driver is out-of-date after the "OMAP DSS2 model restructuring"
patch series got merged:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg23491.html

At least I see this error happening:

<snip>$ make ARCH=arm -j4 uImage >/dev/null
drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c: In function 'nec_8048_panel_probe':
drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c:55: error: 'struct <anonymous>' has no member named 'recommended_bpp'
make[4]: *** [drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.o] Error 1
make[3]: *** [drivers/video/omap2/displays] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [drivers/video/omap2] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

Which is firing after applying this patch:

	OMAP: DSS2: move get_recommended_bpp()

So, I guess you have to rework the panel driver to make it work with latest linux-omap master branch.

Regards,
Sergio
