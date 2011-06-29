From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 7/8] drivers: introduce rpmsg, a remote-processor messaging bus
Date: Wed, 29 Jun 2011 09:30:38 +0300
Message-ID: <BANLkTinDX9ETcqZ=hvSGaao2s=ZcM-JsAg@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
 <1308640714-17961-8-git-send-email-ohad@wizery.com> <20110628164453.aa85c85c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44730 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1F2Ga7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 02:30:59 -0400
In-Reply-To: <20110628164453.aa85c85c.rdunlap@xenotime.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>

Hi Randy,

Thanks for your comments !

On Wed, Jun 29, 2011 at 2:44 AM, Randy Dunlap <rdunlap@xenotime.net> wr=
ote:
>> +hardware accelerators, and therefore are often used to offload cpu-=
intensive
>
> prefer: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPU-
> throughout.

Isn't that changing the meaning a bit ? Let's stick with the original
version, I think it's more clear.

>> +system's physical memory and/or other sensitive hardware resources =
(e.g. on
>> +OMAP4, remote cores (/hardware accelerators) may have direct access=
 to the
>> +physical memory, gpio banks, dma controllers, i2c bus, gptimers, ma=
ilbox
>> +devices, hwspinlocks, etc..). Moreover, those remote processors mig=
ht be
>> +running RTOS where every task can access the entire memory/devices =
exposed
>> +to the processor. To minimize the risks of rogue (/buggy) userland =
code
>
> What is with the leading / here and above (/hardware) and below?

/ here means "or". You can read the sentence twice, either without the
(/ ..) options or with them, and then you get two (different)
examples.

Any idea how to make it more readable ? I prefer not to drop the
second example, as it's adding information.

>> +if RPMSG
>> +
>> +# OK, it's a little counter-intuitive to do this, but it puts it ne=
atly under
>> +# the rpmsg menu (and it's the approach preferred by the virtio fol=
ks).
>> +
>> +source "drivers/virtio/Kconfig"
>
> It seems odd to have that Kconfig file sourced in multiple places.
> Are the kconfig tools happy with that?

They are, probably because these places are mutually exclusive today:

$ git grep "drivers/virtio/Kconfig"
arch/ia64/kvm/Kconfig:source drivers/virtio/Kconfig
arch/mips/Kconfig:source drivers/virtio/Kconfig
arch/powerpc/kvm/Kconfig:source drivers/virtio/Kconfig
arch/s390/kvm/Kconfig:source drivers/virtio/Kconfig
arch/sh/Kconfig:source drivers/virtio/Kconfig
arch/tile/kvm/Kconfig:source drivers/virtio/Kconfig
arch/x86/kvm/Kconfig:source drivers/virtio/Kconfig

Now that we start using virtio for inter-processor communications,
too, we might soon bump into a situation where virtio will be sourced
twice.

Probably the solution is to move 'source "drivers/virtio/Kconfig"'
into drivers/Kconfig, and remove all other instances.

Rusty, are you ok with that ?

Thanks,
Ohad.

> Sorry about the delay. =A0I had most of this in my drafts folder and
> forgot about it...

Np, thanks a lot !

Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
