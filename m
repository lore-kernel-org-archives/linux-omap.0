From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Add am335x-boneblue
Date: Tue, 6 Jun 2017 00:29:46 -0700
Message-ID: <20170606072945.GU3730@atomide.com>
References: <20170530162023.20391-1-robertcnelson@gmail.com>
 <CA+T6QPngRrST_T5HcTXxiGnBq6ba+txocaxrW-QVTuqxzogYuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+T6QPngRrST_T5HcTXxiGnBq6ba+txocaxrW-QVTuqxzogYuw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Drew Fustini <drew-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, James Strawson <jstrawso-fWt/sZ2FBdz2fBVCVOL8/A@public.gmane.org>, Erik Welsh <Erik.Welsh-SM+ZqDzOZfu/3pe1ocb+swC/G2K4zDHf@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org> [170601 00:43]:
> On Tue, May 30, 2017 at 12:20 PM, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > BeagleBone Blue is robotics-oriented version of the BeagleBone Black (BBB).
> >
> > This board can be indentified by the BLAx value after A335BNLT (BBB)
> > in the at24 eeprom:
> > BLAx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 4c 41 30 |.U3.A335BNLTBLA2|]
> >
> > http://beagleboard.org/blue
> > https://github.com/beagleboard/beaglebone-blue
> >
> > firmware: https://github.com/beagleboard/beaglebone-black-wireless/tree/master/firmware
> > wl18xx mac address: /proc/device-tree/ocp/ethernet@4a100000/slave@4a100200/mac-address
> >
> > Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > CC: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
> 
> Acked-by: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>

Applying into omap-for-v4.13/dt.

> Discussed offline the fact that the couple of connectors where we'd
> like to support dynamic pinmuxing that the required pinmux helper code
> is not upstream.

Hmm do you have some link for that? We do have dynamic muxing
working with mainline tree using the named pinctrl modes. At
least omap_hsmmc.c is doing it for am335x SDIO interrupt pin.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
