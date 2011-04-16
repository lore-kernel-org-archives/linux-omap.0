From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Sat, 16 Apr 2011 13:11:56 +0900
Message-ID: <BANLkTim_HWU28idaCFKgJLfxMuBwwb+Nig@mail.gmail.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<4DA84AAB.60601@gmail.com>
	<201104151640.01040.arnd@arndb.de>
	<20110415152643.GC4423@n2100.arm.linux.org.uk>
	<BANLkTinDwH9G1zW784t=QnNR7kZkgfKA8w@mail.gmail.com>
	<20110415154113.GE4423@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44029 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab1DPEL5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Apr 2011 00:11:57 -0400
Received: by gwaa18 with SMTP id a18so1307091gwa.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Apr 2011 21:11:56 -0700 (PDT)
In-Reply-To: <20110415154113.GE4423@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Mundt <lethal@linux-sh.org>

Hi Russell,

[CC Paul Mundt]

On Sat, Apr 16, 2011 at 12:41 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 15, 2011 at 09:32:01AM -0600, Grant Likely wrote:
>> Yes, once the infrastructure is in place, powerpc can do its own
>> migration to the new code. =A0I vote for putting it in lib at the
>> outset.
>
> I don't agree with stuffing non-arch directories with code which peop=
le
> haven't already agreed should be shared. =A0As I've already said, in =
my
> experience it's hard to get agreement in the first place and even whe=
n
> you can the API generally needs to be changed from what you first thi=
nk
> would be reasonable.
>
> So, lets wait to see whether the SH folk reply.

The SH arch is using NUMA for on-chip SRAM on some CPUs, but for
SH-Mobile ARM we have no software support at this point.

The SH/ARM hardware has a bunch of different on-chip memories in
place, and they all have individual power management support through
both clock gating and power domains. I assume other vendors have
similar setups.

I'd like to have some refcounting in place for the SRAM code if
possible, which would trickle down to runtime pm get/put which in turn
would allow us to control the power dynamically. Not sure how easy
that would be to accomplish though.

Paul may have some ideas on how to share the code between ARM and SH.

Thanks,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
