From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH v4 4/4] OMAP: DSS: Add picodlp panel driver
Date: Mon, 16 May 2011 14:19:58 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033DC6BCC1@dbde02.ent.ti.com>
References: <1305033947-4521-1-git-send-email-mayur@ti.com>
	 <1305033947-4521-5-git-send-email-mayur@ti.com>
	 <1305210487.2062.58.camel@deskari>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC168B@dbde02.ent.ti.com>
	 <1305213003.2062.73.camel@deskari>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DC6BA10@dbde02.ent.ti.com>
 <1305529156.2002.22.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56558 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab1EPIuH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 04:50:07 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4G8o4WC022884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 03:50:06 -0500
In-Reply-To: <1305529156.2002.22.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Monday, May 16, 2011 12:29 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org; K, Mythri P
> Subject: RE: [PATCH v4 4/4] OMAP: DSS: Add picodlp panel driver
> 
> On Mon, 2011-05-16 at 09:54 +0530, Janorkar, Mayuresh wrote:
> >
> > > -----Original Message-----
> > > From: Valkeinen, Tomi
> > > Sent: Thursday, May 12, 2011 8:40 PM
> > > To: Janorkar, Mayuresh
> > > Cc: linux-omap@vger.kernel.org; K, Mythri P
> > > Well, when is picodlp_i2c_remove() called? Isn't it called when the
> i2c
> > > client is being removed, i.e. when somebody has called
> > > i2c_unregister_device()?
> >
> > The matching API for i2c_add_device is i2c_del_device.
> 
> These are _driver_ functions not device.
> 
> > And i2c_unregister_device is a matching API for i2c_new_device.
> >
> > i2c_del_device (a call present in picodlp_exit) would call i2c_remove
> > and then i2c_remove has a call to i2c_unregister_device which would
> > unregister the i2c_device.
> >
> > So panel_remove should also have a call to i2c_unregister_device.
> > This would solve the problem.
> 
> I believe panel_remove should be the only place to have
> i2c_unregister_device. It is, as you said, counterpart of
> i2c_new_device, and that is called from panel_probe.

Looks fine.

> 
>  Tomi
> 

