From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/7 v2] OMAP: McSPI: Hwmod adaptation + runtime conversion
Date: Thu, 16 Dec 2010 10:17:18 -0800
Message-ID: <874oadfuq9.fsf@deeprootsystems.com>
References: <33183.10.24.255.18.1291212072.squirrel@dbdmail.itg.ti.com>
	<87d3p3kobt.fsf@deeprootsystems.com>
	<AANLkTikgzMjU9wfzzMjEXzFCUvRz6hKtv=N8dKXf10YM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45276 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757262Ab0LPSRW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 13:17:22 -0500
Received: by pva4 with SMTP id 4so540973pva.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 10:17:22 -0800 (PST)
In-Reply-To: <AANLkTikgzMjU9wfzzMjEXzFCUvRz6hKtv=N8dKXf10YM@mail.gmail.com>
	(Govindraj Raja's message of "Thu, 16 Dec 2010 14:57:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Benoit Cousson <b-cousson@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, Partha Basak <p-basak2@ti.com>

Hi Govindraj,

"Raja, Govindraj" <govindraj.raja@ti.com> writes:

> On Wed, Dec 15, 2010 at 9:42 PM, Kevin Hilman <khilman@deeprootsystem=
s.com>
> wrote:
>
>     "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>     > Changes invloves:
>     > ----------------
>     > 1) Addition of hwmod data for omap2/3/4.
>     > 1) McSPI driver hwmod adaptation with cleanup of base address
>     > =C2=A0 =C2=A0macros and using omap-device API's.
>     > 2) Runtime Conversion of McSPI driver
>     >
>     > Changes from v1:
>     > ---------------
>     > 1) Fixing patch 5/5 comments for hwmod+runtime
>     > =C2=A0 =C2=A0Split the patch 5/5 to hwmod adaptation
>     > =C2=A0 =C2=A0and then runtime conversion
>     > =C2=A0 =C2=A0http://www.mail-archive.com/linux-omap@vger.kernel=
=2Eorg/msg33387.html
>     >
>     > Testing Updates:
>     > ----------------
>     > Was tested using data transfer test module available at:
>     > http://dev.omapzoom.org/?p=3Dricho/device_driver_test.git;a=3Db=
lob;f=3Dmcspi/
>     test_code/
>     > utils/mcspi_modules/omap_mcspi_datatest.c;
>     > h=3De42ec10c5c844abdde6a7175a268b379fbbdb655;
>     > hb=3D5d9a755d50e58de861c5e8991f2f607bc49b5dc3
>
>     Can you summarize what this test does?
>
>     On what platforms was this tested?
>
>     How was it tested for OMAP1 and OMAP2?
>
>
>
> Using the above mentioned test module we had done some
> data transfer tests.
> Platforms used used where :
> 1) OMAP2430 SDP.
> 2) OMAP3 (ZOOM boards zoom2/3).
> 3) OMAP4430 SDP [ Here even basic=C2=A0Ethernet=C2=A0functionality=C2=
=A0was checked which is
> over SPI interface]

Can you describe a little more about the testing please?  What exactly
does the data transfer test do?  Is it a loopback test?  Does it use
on-board SPI peripherals?  If so, which ones, etc.

> We boot tested on 2420/n800.
>
> Coming to omap1,
>
> This driver[omap2_mcspi.c] is applicable only from omap2_plus
> for omap1=C2=A0omap_uwire.c is the spi driver file.

OK, thanks for clarification.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
