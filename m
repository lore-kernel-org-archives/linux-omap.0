From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 3/5] OV3640: Add driver
Date: Mon, 9 Mar 2009 16:29:27 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF3E86F7@dlee02.ent.ti.com>
References: <1236212613.8608.19.camel@tux.localhost>
 <A24693684029E5489D1D202277BE89442E40F7EF@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <A24693684029E5489D1D202277BE89442E40F7EF@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Alexey Klimov <klimov.linux@gmail.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>, MiaoStanley <stanleymiao@hotmail.com>, "Nagalla, Hari" <hnagalla@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Lakhani, Amish" <amish@ti.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Aguirre Rodriguez, Sergio Alberto
> Sent: Monday, March 09, 2009 10:58 PM
> To: Alexey Klimov
> Cc: linux-media@vger.kernel.org; linux-omap@vger.kernel.org; Sakari Ailus;
> Tuukka.O Toivonen; Hiroshi DOYU; DongSoo(Nathaniel) Kim; MiaoStanley;
> Nagalla, Hari; Hiremath, Vaibhav; Lakhani, Amish; Menon, Nishanth
> Subject: RE: [PATCH 3/5] OV3640: Add driver
> 
> 
> > > +       /* FIXME: QXGA framerate setting forced to 15 FPS */
> > > +       if (isize == QXGA) {
<lots of i2c reg writes snip>
> > 4));
> > > +               err = ov3640_write_reg(client, OV3640_ISP_YOUT_L,
> > > +                                                       (height_l -
> > 0x04));
> >
> > The same thing here.
> 
> Agree, will fix..
I wonder if we cannot use an array and fill it up before pumping it out through i2c. something like:
struct configure_array{
	u16 reg;
	u16 val;
}
struct configure_array reg_config[]={
	{OV3640_ISP_YOUT_H, 0x0},
...
};
Then 

for (i=0;i< sizeof(reg_config)/sizeof(configure_array);i++) {
	err = reg_write(reg_config[i].reg, reg_config[i].val);
	if (err) {
		/* do something */
	}
}

Further, we have multiple sensors following CCI[1] - why not have a driver for the same, it will simplify the entire process - ov3640, mt9p012 both follow the spec at least.. dependency would be sensor -> cci dev->i2c framework.

Regards,
Nishanth Menon

Ref:
[1] MIPI CSI2 spec rev 1.0.
