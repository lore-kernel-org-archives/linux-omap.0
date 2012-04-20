From: Rabin Vincent <rabin@rab.in>
Subject: Re: Bug in _und_usr on dual-core ARM?
Date: Fri, 20 Apr 2012 18:07:19 +0530
Message-ID: <CAH+eYFB9BObf6RgdUixWhY-_Cc-HHHO8Q1STq06MEEQhpda9Gw@mail.gmail.com>
References: <BANLkTinY+_+tHatRWuRFUJewUibpmvkUqA@mail.gmail.com> <20110621091529.GA22868@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61816 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab2DTMiM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 08:38:12 -0400
Received: by yhmm54 with SMTP id m54so5055938yhm.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 05:38:12 -0700 (PDT)
In-Reply-To: <20110621091529.GA22868@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: TAO HU <tghk48@motorola.com>, linux-omap <linux-omap@vger.kernel.org>, Zhou Ming-a17711 <a17711@motorola.com>, linux-arm-kernel@lists.infradead.org

On Tue, Jun 21, 2011 at 14:45, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 21, 2011 at 04:31:19PM +0800, TAO HU wrote:
>> We got an issue on our OMAP4 SMP system.
>> Looks like __und_user(), which was triggered by a user space
>> exception, got a page fault hence lead to might_sleep() failure.
>
> Could you see whether this patch prevents the warning please.
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index bc0e1d8..d52b940 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -289,7 +289,7 @@ do_page_fault(unsigned long addr, unsigned int fs=
r, struct pt_regs *regs)
> =A0 =A0 =A0 =A0 * If we're in an interrupt or have no user
> =A0 =A0 =A0 =A0 * context, we must not take the fault..
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (in_atomic() || !mm)
> + =A0 =A0 =A0 if (in_atomic() || irqs_disabled() || !mm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto no_context;
>
> =A0 =A0 =A0 =A0/*

I am able to trigger the discussed warning on current mainline with a
constructed test case, and the above patch does prevent it.  Could it
please be applied?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
