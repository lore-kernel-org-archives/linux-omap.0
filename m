From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM MDK (Re: LDP support)
Date: Mon, 18 May 2009 18:54:56 +0300
Message-ID: <87ljoube3z.fsf@litku.valot.fi>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030555A7D9@dbde02.ent.ti.com>
	<4A03F8DD.4070307@windriver.com> <87hbzv8rua.fsf@litku.valot.fi>
	<20090516081904.GB15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:55091 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbZERPy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 11:54:58 -0400
Received: by bwz22 with SMTP id 22so3294123bwz.37
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 08:54:58 -0700 (PDT)
In-Reply-To: <20090516081904.GB15328@n2100.arm.linux.org.uk> (Russell King's message of "Sat\, 16 May 2009 09\:19\:04 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "stanley.miao" <stanley.miao@windriver.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, jon-hunter@ti.com

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, May 08, 2009 at 07:47:09PM +0300, Kalle Valo wrote:
>> "stanley.miao" <stanley.miao@windriver.com> writes:
>> 
>> >> Looks like you used the CodeSourcery 2007q3 toolchain. This had been
>> >> reported earlier. Switching to 2008q3 works.
>> >
>> > Yeah, Now the kernel booted. it's compiler's problem.
>> 
>> I was bitten by the same problem few weeks ago. Any chance of getting a
>> warning/error if using 2007q3 compiler until the problem is fixed?
>
> Is there any way of detecting the 2007q3 compiler?
>
> With normal GCC versions, you can use __GNUC__, __GNUC_MINOR__ and
> __GNUC_PATCHLEVEL__ to identify the three digit version number.

I don't know, most probably not. But Jon Hunter investigated the issue
and he found the issue was related to CONFIG_ARCH_WANT_FRAME_POINTERS:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12403.html

So maybe we can fix or workaround this.

-- 
Kalle Valo
