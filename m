From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/7] amp/remoteproc: add framework for controlling remote processors
Date: Thu, 5 Jan 2012 15:58:56 +0200
Message-ID: <CAK=WgbZTiS9czticnt4a1TKkR0SmsNKEvdHXfQpwC-N5DMjFXg@mail.gmail.com>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <1319536106-25802-2-git-send-email-ohad@wizery.com> <20120103233534.GC2492@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56276 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab2AEN7S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 08:59:18 -0500
In-Reply-To: <20120103233534.GC2492@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Greg KH <greg@kroah.com>, Stephen Boyd <sboyd@codeaurora.org>

On Wed, Jan 4, 2012 at 1:35 AM, Grant Likely <grant.likely@secretlab.ca=
> wrote:
>> + =A0 =A0 /* go through the available ELF segments */
>> + =A0 =A0 for (i =3D 0; i < ehdr->e_phnum; i++, phdr++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 da =3D phdr->p_paddr;
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 memsz =3D phdr->p_memsz;
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 filesz =3D phdr->p_filesz;
>
> This could be an endianess problem. =A0If the endianess of the host a=
nd
> the rproc are different, then what is the endianess of the elf file?
> Is the endianess of the elf file verified before attempting to parse =
it?
=2E..
> Nitpick: A look up table would be easier to extend in the future.
>
> Otherwise;
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Thanks, Grant!

If I may, I'll add something like this to the commit log:

Acked-by: Grant Likely <grant.likely@secretlab.ca> (minus two
Reported-by issues)

And then we could fix those two issues in two subsequent patches
(carrying your Reported-by) so reviewing the change would be much
easier, and we don't end up changing code (that has been lying in
linux-next) just before it is sent it to Linus.

Thanks a lot for your review!
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
