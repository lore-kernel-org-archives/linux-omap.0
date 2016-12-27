From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: dts: Add am335x-boneblack-wireless
Date: Tue, 27 Dec 2016 10:56:46 -0800
Message-ID: <20161227185645.GZ4920@atomide.com>
References: <20161227175837.28970-1-robertcnelson@gmail.com>
 <20161227175837.28970-2-robertcnelson@gmail.com>
 <CAOCHtYjx+KD3iy1cssjCLN0xjXBGJFZ_e1Qw2zRGbV4=X0+bHg@mail.gmail.com>
 <20161227181429.GY4920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161227181429.GY4920-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161227 10:15]:
> * Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [161227 10:02]:
> > On Tue, Dec 27, 2016 at 11:58 AM, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > BeagleBone Black Wireless is clone of the BeagleBone Black (BBB) with the Ethernet
> > > replaced by a TI wl1835 wireless module.
> > >
> > > This board can be indentified by the BWAx value after A335BNLT (BBB) in the at24 eeprom:
> > > BWAx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 57 41 35  |.U3.A335BNLTBWA5|]
> > >
> > > http://beagleboard.org/black-wireless
> > > https://github.com/beagleboard/beaglebone-black-wireless
> > >
> > > firmware: https://github.com/beagleboard/beaglebone-black-wireless/tree/master/firmware
> > 
> > Tony, this firmware should be there shortly, i have a pull request
> > setup for Jason:
> > 
> > https://github.com/beagleboard/beaglebone-black-wireless/pull/5
> 
> OK great, good to have these working out of the box with mainline
> kernel :)

Hmm so is this firmware file also something that should really be generated
separately for each board? Or can the same one be used for all BBB black
wireless and green boards?

See the LKML thread "[PATCH 0/6] wl1251: Fix MAC address for Nokia N900",
at least with wl1251 the calibration has been done for each n900 device
during production.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
