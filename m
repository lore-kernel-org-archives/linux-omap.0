From: "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v9 01/13] usb: musb: dsps: add phy control logic to glue
Date: Tue, 4 Sep 2012 18:34:19 +0000
Message-ID: <6C6B28D4DC342643927BEAFCE8707BF63E9F58FC@DBDE01.ent.ti.com>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
 <1346411399-23964-2-git-send-email-ravibabu@ti.com>
 <20120831122342.GC24861@arwen.pp.htv.fi>
 <CAAe_U6LaCiEPB9ET26j2xjLtumKzJGu+CtW=fK_02d30Z-3BgQ@mail.gmail.com>
 <20120831131915.GA25341@arwen.pp.htv.fi>
 <6C6B28D4DC342643927BEAFCE8707BF63E9F56A7@DBDE01.ent.ti.com>
 <20120904143505.GH14348@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120904143505.GH14348-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi

> > > > >> AM335x uses NOP transceiver driver and need to enable
> > > builtin PHY
> > > > >> by writing into usb_ctrl register available in 
> system control 
> > > > >> module register space. This is being added at musb 
> glue driver 
> > > > >> layer untill a separate system control module driver is
> > > available.
> > > > >>
> > > > >> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> > > > >> Signed-off-by: Santhapuri, Damodar 
> <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
> > > > >> Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
> > > > >
> > > > > Kishon, you were adding a real phy driver for OMAP's internal 
> > > > > phy logic on one of your patches and I believe this will
> > > conflict with
> > > > > your changes, right ?
> > > > 
> > > > Indeed. My final patch of that series removes some of the 
> > > > functions from omap_phy_internal.c (which was taken 
> care in the phy driver).
> > > > >
> > > > > How does this look to you ? Is this at least correct ? I
> > > suppose the
> > > > > correct way would be to actually have the system 
> control module 
> > > > > driver which we have been waiting, right ?
> > > > 
> > > > Correct. I think once we have the system control module 
> driver in 
> > > > place, we'll have everything wrt control module register writes 
> > > > implemented in correct way.
> > > 
> > > So $SUBJECT will pretty much be thrown away once we have 
> SCM driver, 
> > > in that case it's best to wait a bit longer and apply this series 
> > > once SCM driver is available and after your series too... 
> you agree 
> > > ?
> > > 
> > 
> > Felipe, I am sure there are patches in this series[0/13], which are 
> > not dependent on this patch or control module, Can we pull in those 
> > patches (all dual instances support patches)? So that I can re-work 
> > and submit again?
> 
> sure, will do, don't worry :-)

Thanks.
Then shall I rework patches [3/13 to 13/13] and re-submit only musb dual instances patches which 
are independent of control module. 

> 
> --
> balbi
> --
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
