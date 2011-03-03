From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: Re: State of SDP4430 platform
Date: Thu, 3 Mar 2011 20:53:38 +0530
Message-ID: <AANLkTim2KXZBac_4oBYKkjbebtxmvWAnNAyZUYPecpgm@mail.gmail.com>
References: <20110116010936.GA21795@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1101152255100.13225@utopia.booyaka.com>
	<a40bc7a304b60cef73a3a0cfb84b2ee8@mail.gmail.com>
	<ceedbf20a12a6e821fda1496b10297a2@mail.gmail.com>
	<alpine.DEB.2.00.1101171611270.13225@utopia.booyaka.com>
	<AANLkTinYuEoKNQZ_WRQ6Sd1S0CU4OKNGnxc6_Do3BW+M@mail.gmail.com>
	<alpine.DEB.2.00.1101191625590.7359@utopia.booyaka.com>
	<alpine.DEB.2.00.1101191626570.7359@utopia.booyaka.com>
	<alpine.DEB.2.00.1102071647100.21991@utopia.booyaka.com>
	<alpine.DEB.2.00.1103021149450.16349@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51797 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758190Ab1CCPXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 10:23:40 -0500
Received: by vws11 with SMTP id 11so1261476vws.37
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 07:23:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103021149450.16349@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

>> > > > in ES1, timeouts were observed only with RTC.
>> > > > I2C burst access to IRQ registers and bq24156 were OK
>> > >
>> > > Was an errata generated for this bug?
>> >
>> > er, erratum, pardon me...
>>
>> Is an erratum present for this bug?
>>
>> Also, will you generate a patch for this to at least warn the user when
>> this situation occurs?
>
> Still waiting for a response to this.

Apologies for the delay

Could only find Phoenix TWL6030 - ProDB00107890 for this errata
This is not related to I2C module on OMAP4 so fixing in twl-core.c

Description:
I2C FS burst mode not functional
Glitch in the I2C Data line when the I2C controller does a Burst Read

Have tried to workaround by using single byte read for Phoenix ES1.0
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg46054.html

>
>
> - Paul
>
