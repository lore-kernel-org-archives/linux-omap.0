From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Sat, 17 Jan 2015 18:51:19 +0100
Message-ID: <CAALWOA-v=-KZ5W+Giwq9Z7rdA8JM2Q+zgqZPz-5sDrHD_b-_7A@mail.gmail.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com> <20150117164709.GS18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:38640 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbAQRvl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2015 12:51:41 -0500
Received: by mail-wg0-f52.google.com with SMTP id l2so3383661wgh.11
        for <linux-omap@vger.kernel.org>; Sat, 17 Jan 2015 09:51:40 -0800 (PST)
In-Reply-To: <20150117164709.GS18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

On 17 January 2015 at 17:47, Tony Lindgren <tony@atomide.com> wrote:
> Also looks like the PULL_ENA bit is inverted on dm816x like on am33xx

Yes, ditto on dm814x but there things get even more interesting:

It has the same four config bits as am335x but moved them to bits
16-19, while bits 0-7 contains 1 << mode.  The benefit is that you can
also select no mode at all (high-Z or just the pull if enabled) and
this is in fact the default, though I'm curious what would happen if
multiple bits are set (though not curious enough to risk my hardware
:P ).

It also means you can change mode with a byte-write to avoid touching
the upper bits, which is nice especially since slew is preconfigured
per pin to match I/O timings and you're supposed to never change it
(after fixing the ones ROM messed up due to bugs).  Also on rev 2.x
silicon you're not allowed to disable the receiver if using 3.3V I/O.


> +#define DM816X_IOPAD(pa, val)          OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
> #define AM33XX_IOPAD(pa, val)          OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
> #define AM4372_IOPAD(pa, val)          OMAP_IOPAD_OFFSET((pa), 0x0800) (val)

The overall control module layout is actually compatible across the
whole happy family; basically any register they have in common is at
the same offset (with notable exception of ADC and eCAP event muxes on
am335x versus c6a811x/dra62x, but the latter is a semi-mythical device
anyway, not even a product brief in circulation). They often even have
the same semantics, though padconf shows this isn't always true
unfortunately.

A similar thing is true for the overall device memory map actually:
https://docs.google.com/spreadsheets/d/1hRgpmJ-4Yeojyl8XPO9n3IoYSWKPkg6oRnEvdfV_RaM/view
