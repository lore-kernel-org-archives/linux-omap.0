From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: OMAP totally fucked?
Date: Tue, 06 Mar 2012 17:29:21 +0200
Message-ID: <4F562D51.3000607@ti.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk> <20120303180428.GA10293@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:47262 "EHLO
	na3sys009amx257.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030689Ab2CFP3h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 10:29:37 -0500
Received: by mail-bk0-f47.google.com with SMTP id jg15so6348810bkc.34
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 07:29:25 -0800 (PST)
In-Reply-To: <20120303180428.GA10293@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On 03/03/2012 08:04 PM, Tony Lindgren wrote:
> Then looks like there's a mismerge with ASoC. And ASoC patch
> "[PATCH v3 2/3] MFD: twl6040: Convert to i2c driver, and separate
> it from twl core" that produces another build error.
>=20
> Looks like we also have a new section warning with ASoC changes:
>=20
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x14504): Section misma=
tch in reference from the function omap4_pmic_init() to th
> The function omap4_pmic_init() references
> the (unknown reference) __initdata (unknown).
> This is often because omap4_pmic_init lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
>=20
> Peter, care to look if below is right resolve for the
> mismerge? Also can you please also fix the new section
> warning?

I have sent a revert series (you were on the CC) to Samuel regarding to
this series going via the MFD tree.
I have the corrected series waiting for the event Samuel applies the
reverts on his for-next branch, so we can queue the fixed patches via A=
SoC.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
