From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Add am335x-bonegreen
Date: Fri, 25 Sep 2015 11:23:50 -0500
Message-ID: <CAOCHtYhf1yvQcB073VvT1JKmut7M7cdL9a7Ms42AxyuOOWj6-A@mail.gmail.com>
References: <1443193831-5693-1-git-send-email-robertcnelson@gmail.com>
 <5605704D.5000404@ti.com> <CAOCHtYhuLREw_eKbME+Ssvx=JrHWtbFZPQRH5SrmfVTiSqdtWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOCHtYhuLREw_eKbME+Ssvx=JrHWtbFZPQRH5SrmfVTiSqdtWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

>>
>> Would still work when https://patchwork.kernel.org/patch/6394821/ gets in?
>
> That will still work, but we need to extend the board identification
> to "board-name" + "board-revision", as the Green choose the "A335BNLT"
> board name in the eeprom to remain compatible with older 3.8.x images
> from last year.. (most of the clones i've talked too want to support
> the old image too)...
>
> So with the 1st byte of the board-revision:
> All BeagleBone Black's have: 0x30
> Seeed's using 0x1A (with the potential to increment the A)

I should add, we have an official-ish list at the top of (1), to help
keep track of this...

1: https://github.com/beagleboard/image-builder/blob/master/readme.md

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
