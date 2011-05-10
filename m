From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH v3 4/4] OMAP: DSS: Add picodlp panel driver
Date: Tue, 10 May 2011 17:34:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033DB08766@dbde02.ent.ti.com>
References: <1304954319-8386-1-git-send-email-mayur@ti.com>
	 <1304954319-8386-5-git-send-email-mayur@ti.com>
	 <1305020000.3237.16.camel@lappyti>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DB0868E@dbde02.ent.ti.com>
 <1305026069.2045.27.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57390 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab1EJMEZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 May 2011 08:04:25 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4AC4L5P031792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 07:04:24 -0500
In-Reply-To: <1305026069.2045.27.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Tuesday, May 10, 2011 4:44 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH v3 4/4] OMAP: DSS: Add picodlp panel driver
> 
> On Tue, 2011-05-10 at 15:57 +0530, Janorkar, Mayuresh wrote:
> 
> > > It is better to request and initialize the GPIOs in the board file.
> The
> > > reason for this is that the PicoDLP device should be off if it's not
> > > used, or if the driver is not even compiled in. So the board file
> should
> > > make sure that the GPIOs are in such state that the device is off.
> >
> > The board file has only init. There is no exit.
> > So if I request gpios in init once, I could not find a place to free
> them.
> 
> If the GPIOs are not shared, and they go only to picodlp, there's not
> really any need to free them. They are not a shared resource, and they
> can be kept reserved for picodlp all the time.
> 
> > Is it a good idea to request gpios in platform_enable and free them in
> platform_disable?
> 
> No, that wouldn't fix the problem.
> 
> For example, consider a case where the kernel is compiled without
> picodlp driver. So platform_enable/disable is never called, and the
> GPIOs are never requested or initialized. This means that depending on
> the values of the GPIOs, the picodlp could be always on, consuming
> power.
> 
> So my suggestion is to request all the GPIOs in the board file, in
> display init, and initialize the GPIOs to some sane value so that the
> picodlp is off. Then pass the two GPIOs to the picodlp driver, which can
> then use the GPIOs, and handle the two other GPIOs in the board file in
> platform_enable/disable.

Looks fine.
I would set:
OMAP4_DLP_DISPLAY_SELECT_GPIO to 0,
OMAP4_DLP_POWER_ON_GPIO to 0,
And pwrgood_gpio to 1,
as init values of these gpios.

> 
>  Tomi
> 

