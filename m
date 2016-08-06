From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Letux-kernel] [PATCH v2] musb: omap2430: do not assume balanced
 enable()/disable()
Date: Fri, 5 Aug 2016 23:21:35 -0700
Message-ID: <20160806062134.GK28140@atomide.com>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
 <FFDA9A63-599B-44CA-B244-C8860D9E01D9@goldelico.com>
 <20160804142919.GG28140@atomide.com>
 <20160804183129.2e0cac71@aktux>
 <20160804184402.73963e8a@aktux>
 <20160805135501.GJ28140@atomide.com>
 <20160805172039.6dac0aeb@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160805172039.6dac0aeb@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap <linux-omap@vger.kernel.org>, Bin Liu <b-liu@ti.com>
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [160805 08:35]:
> I repeat the subject line of the patch:
> [PATCH v2] musb: omap2430: do not assume balanced enable()/disable()
> It is *not* fix charging.
> 
> So you mean that the phy should magically know at which refcounter
> it should power on and off if power on/off is not called in the
> balanced way?

No, I mean we need to figure out why things can be called in
unbalanced way. With your patch I end up with unbalanced calls
leaving the phy on after all the modules have been removed :)

> Maybe the phy-twl4030 uses the phy layer wrong. 
> Now the relevant part of power on/off in phy-twl4030 is done via struct
> phy_ops.power_off/power_on (*not* via pm_runtime). Maybe that is wrong
> and more parts should be moved to the pm_runtime stuff (which is also
> present). 

We should use phy power_off/power_on for the USB related parts.
The parts needed by other components, like VBUS detection, should
be handled by PM runtime. We should get phy-twl4030-usb and the
charger driver working also when no musb modules are loaded.

> Then the phy subsystem has its own power refcounter in struct
> phy.power_count. It it handled via phy_power_off()/phy_power_on().
> And that is called from musb/omap2430.c 
> But that is another story. 

Yes that's what the USB driver is expected to do. But obviously
there are issues remaining also in the phy-twl4030-usb.c driver.
And it seems that we should have some OTG parts always enabled
when VBUS is detected when twl4030-charger is configured?

> > If there are MUSB specific PM runtime issues then let's fix
> > those separately.
> > 
> And that exactly tries my patch to do. For that task it does not
> even use the PM runtime system. Again please read the subject line of
> the patch. Maybe it unveils some other pm issues in musb
> which should first be fixed in a complete patch series.

Certainly that needs to be fixed, but let's do it in a way where
things work for other test cases also. Care to describe how to
to reproduce the issue you're seeing? It seems that you are
seeing devices not being enmerated leading to the charger not
working? Is this with built in MUSB and phy modules?

Regrds,

Tony
