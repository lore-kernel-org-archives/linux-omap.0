From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH v4 4/4] OMAP: DSS: Add picodlp panel driver
Date: Mon, 16 May 2011 09:54:25 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033DC6BA10@dbde02.ent.ti.com>
References: <1305033947-4521-1-git-send-email-mayur@ti.com>
	 <1305033947-4521-5-git-send-email-mayur@ti.com>
	 <1305210487.2062.58.camel@deskari>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC168B@dbde02.ent.ti.com>
 <1305213003.2062.73.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44175 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab1EPEYg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 00:24:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4G4OX2Q024890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 15 May 2011 23:24:35 -0500
In-Reply-To: <1305213003.2062.73.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Thursday, May 12, 2011 8:40 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org; K, Mythri P
> Subject: RE: [PATCH v4 4/4] OMAP: DSS: Add picodlp panel driver
> 
> On Thu, 2011-05-12 at 20:25 +0530, Janorkar, Mayuresh wrote:
> >
> > > -----Original Message-----
> > > From: Valkeinen, Tomi
> > > Sent: Thursday, May 12, 2011 7:58 PM
> > > To: Janorkar, Mayuresh
> > > Cc: linux-omap@vger.kernel.org; K, Mythri P
> > > Subject: Re: [PATCH v4 4/4] OMAP: DSS: Add picodlp panel driver
> > >
> > > On Tue, 2011-05-10 at 18:55 +0530, Mayuresh Janorkar wrote:
> > > > picodlp panel driver is required for driving DLP dpp2600.
> > > > It consists of a dss driver and an i2c_client.
> > > >
> > > > i2c_client is required for sending commands to dpp (DLP Pico
> Projector).
> > > >
> > > > Based on original design from Mythri P K <mythripk@ti.com>
> > > >
> > > > The power-up sequence consists of:
> > > > Setting PWRGOOD to a logic low state. Once power is stable and thus
> the
> > > ++++++++++++++++++++++++++
> > > >  3 files changed, 622 insertions(+), 0 deletions(-)
> > > >  create mode 100644 drivers/video/omap2/displays/panel-picodlp.c
> >
> > <snip>
> >
> > > > +
> > > > +#include <plat/display.h>
> > > > +#include <plat/panel-picodlp.h>
> > > > +
> > > > +#include "panel-picodlp.h"
> > > > +
> > > > +#define DRIVER_NAME	"picodlp_i2c_driver"
> > > > +
> > > > +#define MAX_TRIAL_VALUE			100
> > >
> > > I'll repeat my comment from previous review round:
> > >
> > > The name of this define is not descriptive and you use this define in
> > > two places which have nothing to do with each other. I think it's
> better
> > > just to use the value where it's needed.
> >
> > I think it looks more readable if we have a MACRO.
> > But as they are used at only couple of places I would remove these
> MACROs.
> 
> Well, the problem with this macro is that it's very unclear. What does
> max trial value mean? It doesn't define anything sensible, just a number
> which doesn't mean anything without the code context.
> 
> If it was MAX_TRIAL_TIME_MS, telling the maximum time in milliseconds
> that the code would wait, then it would be sensible.
> 
> Another problem is that you used the same macro in two different places,
> which have nothing to do with each other. The other place requires a
> wait of 500ms, if I recall right, and is related to the power up. The
> other one is related to waiting for some DMA transfer inside pico to
> finish, and this time is in microseconds or possibly few milliseconds if
> I understood right.
> 
> It's not good to use the same define in such different places,
> especially as it only defines a max loop number, so it depends on the
> msleeps in the code.
> 
> > >
> > > > +struct picodlp_data {
> > > > +	struct mutex lock;
> >
> >
> > > > +static int picodlp_i2c_remove(struct i2c_client *client)
> > > > +{
> > > > +	struct picodlp_i2c_data *picodlp_i2c_data =
> > > > +					i2c_get_clientdata(client);
> > > > +
> > > > +	kfree(picodlp_i2c_data);
> > > > +	i2c_unregister_device(client);
> > >
> > > You add the i2c device in the dss probe function, but unregister it in
> > > i2c remove function. That's probably not right. These things should
> > > usually be symmetric, and the unregister should be at the dss remove
> > > function.
> > >
> > Isnt it good to have a remove function removing i2c_client?
> 
> Well, when is picodlp_i2c_remove() called? Isn't it called when the i2c
> client is being removed, i.e. when somebody has called
> i2c_unregister_device()?

The matching API for i2c_add_device is i2c_del_device.
And i2c_unregister_device is a matching API for i2c_new_device.

i2c_del_device (a call present in picodlp_exit) would call i2c_remove and then i2c_remove has a call to i2c_unregister_device which would unregister the i2c_device.

So panel_remove should also have a call to i2c_unregister_device.
This would solve the problem.

> 
>  Tomi
> 

