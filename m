From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH v2] musb: omap2430: do not assume
 balanced enable()/disable()
Date: Fri, 5 Aug 2016 17:20:39 +0200
Message-ID: <20160805172039.6dac0aeb@aktux>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
	<FFDA9A63-599B-44CA-B244-C8860D9E01D9@goldelico.com>
	<20160804142919.GG28140@atomide.com>
	<20160804183129.2e0cac71@aktux>
	<20160804184402.73963e8a@aktux>
	<20160805135501.GJ28140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160805135501.GJ28140@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap <linux-omap@vger.kernel.org>, Bin Liu <b-liu@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 5 Aug 2016 06:55:01 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [160804 09:44]:
> > Nothing happens here, so the previous state of the phy remains.
> > It would be disabled by the generic phy layer in
> > drivers/phy/phy-core.c
> >
> > > gadget driver is loaded.
> > > musb_start() is called
> > >     omap2430_musb_enable() is called
> > > 	calls phy_power_on(),
> > > 	phy->power_count goes to 0,
> > > 	phy is not powered on because power_count != 1
> > > -> no gadget working, no charging.
> > > 
> > ... if not configured by u-boot before. USB gadget might work when
> > initialized earlier in the boot process (u-boot/x-loader/mlo ...)
> > and phy-twl4030 cannot do anything about it besides if we change
> > drivers/phy/phy-core.c
> 
> Ssounds like an issue in the phy-twl4030-usb.c. Let's try to figure
> out what all we need set there for the various components there.
> 
> PM runtime for phy-twl4030-usb.c should be for the whole PHY
> device including all it's components. Then the charger and
> MUSB should separately increment the PM runtime count and then
> enable the component specific things. And then we have the
> errata to deal with when VBUS is enabled.

I repeat the subject line of the patch:
[PATCH v2] musb: omap2430: do not assume balanced enable()/disable()
It is *not* fix charging.

So you mean that the phy should magically know at which refcounter
it should power on and off if power on/off is not called in the
balanced way?

Maybe the phy-twl4030 uses the phy layer wrong. 
Now the relevant part of power on/off in phy-twl4030 is done via struct
phy_ops.power_off/power_on (*not* via pm_runtime). Maybe that is wrong
and more parts should be moved to the pm_runtime stuff (which is also
present). 
Then the phy subsystem has its own power refcounter in struct
phy.power_count. It it handled via phy_power_off()/phy_power_on().
And that is called from musb/omap2430.c 
But that is another story. 

> 
> If there are MUSB specific PM runtime issues then let's fix
> those separately.
> 
And that exactly tries my patch to do. For that task it does not
even use the PM runtime system. Again please read the subject line of
the patch. Maybe it unveils some other pm issues in musb
which should first be fixed in a complete patch series.

Regards,
Andreas
