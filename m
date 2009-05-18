From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM MDK (Re: LDP support)
Date: Mon, 18 May 2009 10:13:55 -0700
Message-ID: <87zlda72r0.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030555A7D9@dbde02.ent.ti.com>
	<4A03F8DD.4070307@windriver.com> <87hbzv8rua.fsf@litku.valot.fi>
	<20090516081904.GB15328@n2100.arm.linux.org.uk>
	<87ljoube3z.fsf@litku.valot.fi>
	<20090518160957.GD7042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:50519 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbZERRN6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 13:13:58 -0400
Received: by pzk13 with SMTP id 13so2075028pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 10:13:58 -0700 (PDT)
In-Reply-To: <20090518160957.GD7042@n2100.arm.linux.org.uk> (Russell King's message of "Mon\, 18 May 2009 17\:09\:57 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kalle Valo <kalle.valo@iki.fi>, "stanley.miao" <stanley.miao@windriver.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, jon-hunter@ti.com

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, May 18, 2009 at 06:54:56PM +0300, Kalle Valo wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> > On Fri, May 08, 2009 at 07:47:09PM +0300, Kalle Valo wrote:
>> >> "stanley.miao" <stanley.miao@windriver.com> writes:
>> >> 
>> >> >> Looks like you used the CodeSourcery 2007q3 toolchain. This had been
>> >> >> reported earlier. Switching to 2008q3 works.
>> >> >
>> >> > Yeah, Now the kernel booted. it's compiler's problem.
>> >> 
>> >> I was bitten by the same problem few weeks ago. Any chance of getting a
>> >> warning/error if using 2007q3 compiler until the problem is fixed?
>> >
>> > Is there any way of detecting the 2007q3 compiler?
>> >
>> > With normal GCC versions, you can use __GNUC__, __GNUC_MINOR__ and
>> > __GNUC_PATCHLEVEL__ to identify the three digit version number.
>> 
>> I don't know, most probably not. But Jon Hunter investigated the issue
>> and he found the issue was related to CONFIG_ARCH_WANT_FRAME_POINTERS:
>> 
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12403.html
>> 
>> So maybe we can fix or workaround this.
>
> Why does this change anything?  FRAME_POINTERS seems to be enabled
> anyway (and should be given the Kconfig setup we have.)

See the 'depends on' line in lib/Kconfig.debug.  The result is that
without the patch from Jon, even if you have CONFIG_FRAME_POINTERS=y
in your .config, it gets dropped if the arch doesn't set
CONFIG_ARCH_WANT_FRAME_POINTERS.

Kevin
