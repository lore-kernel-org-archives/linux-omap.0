From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
Date: Fri, 2 Sep 2016 08:52:10 -0500
Message-ID: <CAOCHtYiFjB-cuABmCiw96spc-De+qNNQYGrjp-MmNDuH2mJ9Bw@mail.gmail.com>
References: <20160902090600.27262-1-nm@ti.com> <20160902090600.27262-3-nm@ti.com>
 <dd74f5e1-304f-661e-7fd9-f5f81bcfc55e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <dd74f5e1-304f-661e-7fd9-f5f81bcfc55e-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 2, 2016 at 5:41 AM, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> + Robert Nelson
>
> On Friday 02 September 2016 02:36 PM, Nishanth Menon wrote:
>
> I understand that there are existing users of A2 boards and so we simply
> cannot remove support for those boards (at least yet).
>
> But given the small numbers of A2 boards, its also quite likely that we
> will not have enough test coverage for those boards. Especially as years
> pass and there are fewer and fewer people with access to working A2 boards.

I have a A1, A2 and a B1, that i use for testing for
beagleboard.org...  The A1 use to be ssh-accessible for developers,
but since moving to my new house, I haven't "yet" got that one setup
for developers.  Right now i'm using the A2 & B1 for development of
our default images.

Jason Kridner also has a number of boards

> Given that, aren't we increasing the chance of A2 breakage by creating a
> common file - this essentially necessitates that any change to
> am57xx-beagle-x15-common.dtsi is also tested on A2.
>
> Instead, it seems to be easier for maintenance and safer overall if the
> older version has a file of its own which can be kept alone.
>
> Also, how about renaming the existing dts to am57xx-beagle-x15-reva2.dts
> and let the production version be called am57xx-beagle-x15.dts? Surely
> this will cause some inconvenience to A2 users. But there are few users
> of those and it might be more intuitive for the majority users if the
> file for production version is without a specific version string
> attached. Just a thought though, not sure about it myself either.

Nak, let's NOT do that to A2 users.

The am57xx-beagle-x15.dts went mainline in v3.19, u-boot installed on
devices would need to be updated and this would make bisecting a pain.
;)

Side note:

A1/A2 boards (most i believe) did not have the eeprom programmed with an ID.

Where as B1's have a default eeprom for identification:

https://github.com/RobertCNelson/boot-scripts/blob/master/device/x15/X15_B1-eeprom.dump

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
