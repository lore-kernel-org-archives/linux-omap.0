From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH D 01/11] OMAP: Add clk_get_parent() for OMAP2/3
Date: Sat, 31 Jan 2009 16:51:20 +0000
Message-ID: <yw1xvdrv4dx3.fsf@thrashbarg.mansr.com>
References: <20090128191638.16688.33452.stgit@localhost.localdomain>
	<20090128191807.16688.91255.stgit@localhost.localdomain>
	<20090129110043.GE12627@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.0901292327090.26985@utopia.booyaka.com>
	<20090131142344.GM1394@n2100.arm.linux.org.uk>
	<yw1xhc3f5xb9.fsf@thrashbarg.mansr.com>
	<20090131152620.GN1394@n2100.arm.linux.org.uk>
	<yw1x4ozf5vtw.fsf@thrashbarg.mansr.com>
	<20090131155631.GO1394@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from agrajag.mansr.com ([78.86.181.102]:46616 "EHLO mail.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbZAaQvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2009 11:51:22 -0500
In-Reply-To: <20090131155631.GO1394@n2100.arm.linux.org.uk> (Russell King's message of "Sat, 31 Jan 2009 15:56:31 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sat, Jan 31, 2009 at 03:39:07PM +0000, M=E5ns Rullg=E5rd wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>>=20
>> > On Sat, Jan 31, 2009 at 03:07:06PM +0000, M=E5ns Rullg=E5rd wrote:
>> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> >> > Great, thanks.  However, I'd forgotten that one of my patches
>> >> > completely removes clk_get_parent() since it's unused by any
>> >> > code in OMAP at present.
>> >> >
>> >> > What was the reasoning behind making this work?
>> >>=20
>> >> It is needed for the omapfb/dss driver to set an optimal rate for
>> >> dpll4_m4_ck.
>> >
>> > I assume this isn't merged yet?  Where can I see what it's doing?
>>=20
>> The new DSS driver by Tomi Valkeinen uses it.  Patches have been
>> posted to the linux-omap list.
>
> Can't find them.  Found the DSS patches posted on the 12th but they d=
on't
> use clk_get_parent().
>
> So, I repeat.  Where can I see where this function is used?

I have the patches applied in my git tree:
http://git.mansr.com/?p=3Dlinux-omap;a=3Dblob;f=3Darch/arm/plat-omap/ds=
s/dispc.c;h=3De6954637b113c66cb6a0ee8c7c4c3993d170b4a3;hb=3DHEAD#l1494

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
