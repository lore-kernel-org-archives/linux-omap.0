From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [RFC 0/5] Sensor drivers for OMAP3430SDP and LDP camera
Date: Wed, 4 Mar 2009 09:40:04 -0600
Message-ID: <A24693684029E5489D1D202277BE89442E2968B6@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89442E1D95E5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <A24693684029E5489D1D202277BE89442E1D95E5@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "stanley.miao" <stanley.miao@windriver.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>, MiaoStanley <stanleymiao@hotmail.com>, "Nagalla, Hari" <hnagalla@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org



> From: stanley.miao [mailto:stanley.miao@windriver.com]
> > Aguirre Rodriguez, Sergio Alberto wrote:
> > > This patch series depends on the following patches:
> > >
> > >  - "Add TWL4030 registers", posted by Tuukka Toivonen on March 2nd.
> > >  - "OMAP3 ISP and camera drivers" patch series, posted by Sakari Ailus
> > on
> > >    March 3rd. (Please follow his instructions to pull from
> gitorious.org
> > server)
> > >
> > > This has been tested with:
> > >  - SDP3430-VG5.0.1 with OMAP3430-ES3.1 daughter board upgrade.
> > >  - Camkit V3.0.1 with MT9P012 and OV3640 sensors
> > >  - LDP with OV3640 sensor
> > >
> > > Sergio Aguirre (5):
> > >   MT9P012: Add driver
> > >   DW9710: Add driver
> > >   OV3640: Add driver
> > >
> > Hi, Sergio,
> >
> > You forgot to send the 3rd patch, "OV3640: Add driver".
> 
> Hmm, weird... I'm sure I have sent the 5 patches to both linux-omap and
> linux-media MLs... But, according to http://patchwork.kernel.org/ linux-
> omap didn't receive that patch you're telling me...
> 
> Anyways, resending that last patch to linux-omap only.
> 
> Thanks for the interest.

Stanley,

I don't know why this patch is not making it... I resent it twice now, and it doesn't arrive to the list...

Tony,

Is this patch "OV3640: Add driver" being held on a mail filter somewhere?

Regards,
Sergio
> 
> >
> > Stanley.
> >
> > >   OMAP3430SDP: Add support for Camera Kit v3
> > >   LDP: Add support for built-in camera
> > >
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

