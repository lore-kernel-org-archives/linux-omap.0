From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: OMAP3 display  patches
Date: Wed, 30 Jun 2010 12:48:23 +0300
Message-ID: <1277891303.2474.177.camel@tubuntu.research.nokia.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BDB3A55F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54290 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab0F3Js5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 05:48:57 -0400
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BDB3A55F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Nagarajan, Rajkumar" <x0133774@ti.com>
Cc: "Mittal, Mukund" <mmittal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>

On Tue, 2010-06-29 at 14:20 +0200, ext Nagarajan, Rajkumar wrote:
> Tomi,
> 
> Would you please check if there are no further comments and can you please pull the following patches in?
> 
> https://patchwork.kernel.org/patch/106498/

What exactly is the purpose of this patch? The patch description doesn't
really tell me anything. The input size is supposed to come from omapfb
(or V4L2).

It also seems to add a module parameter, without even mentioning it in
the description.

There's also a typo in the description (sysfx).

> https://patchwork.kernel.org/patch/106670/

See Ville's comment about this.

I'd also like to have the sysfs files to be created only when they are
actually applicable, ie. pre_multiplication_alpha would be created only
for 3630, and for overlays that support it.

However, no other DSS sysfs file support this currently, and I'm not
sure what it would mean to support this.

> https://patchwork.kernel.org/patch/107547/

See Ville's and Koen's comments about this.

 Tomi


