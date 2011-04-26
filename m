From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [PATCH 5/7] OMAP: DSS: Adding initialization routine to
 picodlp panel
Date: Tue, 26 Apr 2011 13:47:21 +0300
Message-ID: <1303814841.4989.44.camel@deskari>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
	 <1303107350-22747-6-git-send-email-mayur@ti.com>
	 <1303213962.32281.46.camel@deskari>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033D8839FB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:50825 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752427Ab1DZKr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 06:47:26 -0400
Received: by mail-fx0-f53.google.com with SMTP id 8so350017fxm.26
        for <linux-omap@vger.kernel.org>; Tue, 26 Apr 2011 03:47:25 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033D8839FB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>

On Thu, 2011-04-21 at 16:47 +0530, Janorkar, Mayuresh wrote:
> 
> > -----Original Message-----
> > From: Valkeinen, Tomi
> > Sent: Tuesday, April 19, 2011 5:23 PM
> > To: Janorkar, Mayuresh
> > Cc: linux-omap@vger.kernel.org; K, Mythri P
> > Subject: Re: [PATCH 5/7] OMAP: DSS: Adding initialization routine to
> > picodlp panel
> > 
> > On Mon, 2011-04-18 at 11:45 +0530, Mayuresh Janorkar wrote:

<snip>

> > >  static int picodlp_i2c_probe(struct i2c_client *client,
> > >  		const struct i2c_device_id *id)
> > >  {
> > > @@ -134,6 +446,11 @@ static int picodlp_panel_power_on(struct
> > omap_dss_device *dssdev)
> > >  	picodlp_i2c_data =
> > >  		i2c_get_clientdata(picod->picodlp_i2c_client);
> > >
> > > +	msleep(700); /* sleep till panel is settled */
> > 
> > And another huge sleep. This, unlike the other sleeps, make some sense,
> > as there's an i2c transaction done below.
> > 
> > Somehow I get the feeling that you've just put big sleeps here and there
> > until the driver started working... Can you point me to the
> > documentation that describes the delays required?
> 
> Except msleep(5) in
> /* transfer control to flash controller */
> r = picodlp_i2c_write(client, PBC_CONTROL, 1);
>         msleep(5);
> r = picodlp_i2c_write(client, PBC_CONTROL, 0); 
> 
> Other delays are not documented. But it is practically observed that we need to wait otherwise the i2c_packet does not succeed.

Then we need to contact the HW guys developing picodlp. They are TIers,
aren't they? We can't just put sleeps here and there and be sure it'll
work properly.

What if your sleep of 700ms has, by luck, caused a 900ms sleep in your
tests (sleeps can take considerably longer than the given value), and
the hardware requires 800ms sleep? Your tests show it works, but for
some other user the sleep may cause a 750ms sleep, causing picodlp to
fail to start.

 Tomi


