From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sun, 1 Feb 2015 02:36:06 +0100
Message-ID: <CAALWOA9-wXZCY8QVZmZR7vymEQYupyOm=uJD8bJf-cC7uEfi0A@mail.gmail.com>
References: <20131206213613.GA19648@earth.universe> <201501241140.34479@pali>
 <CAALWOA92XmRoJwg5vcL+bLQU-O+6Guxgq4cq+76kYRbLOL+i6Q@mail.gmail.com> <201501312009.58483@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:61810 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156AbbBABg2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2015 20:36:28 -0500
Received: by mail-wg0-f46.google.com with SMTP id l2so32954140wgh.5
        for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2015 17:36:27 -0800 (PST)
In-Reply-To: <201501312009.58483@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Joel Fernandes <joelf@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@ring0.de>

On 31 January 2015 at 20:06, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> Just to note that above error output is from device where is
> signed X-Loader which *enable* omap aes support.
>
> So it looks like it is not possible to dump registers which
> should tell you if kernel has permission or not (in L3 firewall).

This is hardly surprising on a HS device.  If the firewalls are
actively being used to enforce access control rather than being left
wide open like they are by default on GP devices, the firewalls
themselves will *certainly* be firewalled off.

(Though they could have opted for granting read-only access to the L3
firewalls for inspection, as I mentioned it's the L4-Core firewall
which matters here and these do not even have the option of providing
read-only access.)


On 31 January 2015 at 20:09, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> Do you have idea if it is possible to write such check in kernel
> if address (aes@480c5000) is readable or not?

Most of my experience with TI SoCs so far has actually been baremetal
programming, so I have to admit I'm not yet as familiar as I'd like
with how things are done in the linux kernel.

But if I'm reading arch/arm/mm/fault.c right, kernel level exception
handling is currently only invoked for translation faults and not for
synchronous external aborts. If that were fixed, then something like a
privileged version of __get_user_asm_word
(arch/arm/include/asm/uaccess.h) could be used.  Hmm, in fact, it
appears __get_user actually performs a privileged load unless
CONFIG_CPU_USE_DOMAINS is enabled... odd.

My intuition is that this shouldn't be very difficult, but invoking
fixup_exception for synchronous external aborts in addition to
translation faults would be a semantic change with kernel-wide scope,
so I don't know if this might be a big no-no for non-obvious reasons.


> I have configured two testing N900 devices. One with signed
> bootloader which enable omap aes support and one device with
> signed bootloader which does not enable omap aes support.

I'm probably missing some context here, but why not just use the one
with aes support? Alternatively, one may argue that it's the
bootloader's job to provide the kernel with an accurate device tree.
(Though one may equally well argue that it would be nice to avoid
having to customize the device tree for every feature-flavor of a
processor, especially if this depends on how it's initialized.)

BTW, I noticed they actually do list the A/P regions and default
protection groups in the TRMs, including the "secret" ones. It's not
presented in a very readable form though, so I've converted the one
for L4-Core into yet another addition to my spreadsheet collection:
https://docs.google.com/spreadsheets/d/1HhK3bIoaDzJoEGW1zDO5yTRQMdqC8Nf=
tWHHUCS5QVmA/view
I started filling in the descriptions but then got lazy :P  If anyone
wants edit permissions just mail me.  I already noticed one
inconsistency though (it claims 48308800-FFF is valid and 48308000-7FF
is not, while the TRM elsewhere claims the opposite) so it would still
be better if someone with access to a GP omap34xx/omap35xx dumps the
actual tables from hardware to avoid human error.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
