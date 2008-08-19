From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Tue, 19 Aug 2008 07:26:51 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036217F694@dlee02.ent.ti.com>
References: <20080818.180829.145776296.Hiroshi.DOYU@nokia.com>
 <EBA93F3E4CB46947A4C5275F6308CF3E03435165@dlee15.ent.ti.com>
 <5d5443650808181020l19e9bce2g9ccb59979f626a93@mail.gmail.com>
 <20080819062020.GC17276@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37850 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbYHSM1F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 08:27:05 -0400
In-Reply-To: <20080819062020.GC17276@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Trilok Soni <soni.trilok@gmail.com>
Cc: "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

> > I think recently some one from TI posted OMAP3 camera driver at
> > linux-v4l2 mailing list and which I think was using camera MMU, but
> > not the common MMU framework it seems from the description. They
> > should first start converting to the common MMU infrastructure then.
> >
> > http://lists-archives.org/video4linux/23215-omap3-camera-driver.html
>
> We must make the MMU framework generic for the coprocessors, otherwise
> maintenance will be a nightmare and the code will never get merged
> upstream.

Main issues are at outer interfaces which deal with OS memory system interaction.  The other aspects of the code have been self contained.

The local MMU usages are not maintenance intensive like linux PTE structures as Linux more strongly couples with the hardware table representations.

Seems some of the subsystems like v4l2 do provide local abstractions but there isn't always global ones (vmalloc to sg list for example).

Seems main benefit would be if there were common map conversion and flushing code.

Regards,
Richard W.

