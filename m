From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Current state of AM33xx patches
Date: Fri, 29 Jun 2012 17:43:47 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5FC0F@DBDE01.ent.ti.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com>
 <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com>
 <4FE9A00B.6010908@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com>
 <4FEC7394.9030208@gmail.com> <4FEDB37C.4070604@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37309 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117Ab2F2Rn5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 13:43:57 -0400
In-Reply-To: <4FEDB37C.4070604@visionsystems.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "yegor_sub1@visionsystems.de" <yegor_sub1@visionsystems.de>, Daniel Mack <zonque@gmail.com>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>

On Fri, Jun 29, 2012 at 19:24:04, Yegor Yefremov wrote:
> Am 28.06.2012 17:09, schrieb Daniel Mack:
> > On 27.06.2012 14:13, Hiremath, Vaibhav wrote:
> > 
> >> Just to clarify from AM335x perspective,
> >>
> >> In case of AM335x, since the patches and complete BasePort support is still
> >> not present in the Mainline (neither in Linus's tree not in linux-omap), you 
> >> need to use my Repo (https://github.com/hvaibhav: Closely follows linux-
> >> omap/master) in order to test something on BeagleBone platform.
> > 
> > Great, that is the information I've been looking for.
> > 
> > Your am335x-upstream-staging branch works for me on a custom AM335x
> > based board using a custom DT config.
> > 
> > I'll dig through the sources and come back once I know which parts are
> > missing.
> 
> Do you have LCD screen attached? I need a functioning framebuffer driver. So far if I start x-server I get various errors:
> 
> (EE) FBDEV(0): internal error: miCreateDefColormap failed in FBDevScreenInit()
> 

Did you get a chance to dig on this? Do you have further level of details 
from driver perspective? Which IOCTL is failing here? What is return value?


Thanks,
Vaibhav
