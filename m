From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 0/7] Add TI EMIF SDRAM controller driver
Date: Thu, 3 May 2012 11:45:37 +0530
Message-ID: <CAMQu2gzBjnuc=zZ+Ug+YW+ViQFr25YuWFHBL5iXQDJ_7dPtAOg@mail.gmail.com>
References: <1335529449-28046-1-git-send-email-santosh.shilimkar@ti.com>
 <20120502051623.GA23705@kroah.com> <4FA0D930.3080806@ti.com> <20120502180322.GA28837@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59680 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750804Ab2ECGQA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 02:16:00 -0400
Received: by qabj40 with SMTP id j40so9989qab.1
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 23:15:59 -0700 (PDT)
In-Reply-To: <20120502180322.GA28837@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, May 2, 2012 at 11:33 PM, Greg KH <gregkh@linuxfoundation.org> w=
rote:
> On Wed, May 02, 2012 at 12:20:24PM +0530, Santosh Shilimkar wrote:
>> Greg,
>>
>> On Wednesday 02 May 2012 10:46 AM, Greg KH wrote:
>> > On Fri, Apr 27, 2012 at 05:54:02PM +0530, Santosh Shilimkar wrote:
>> >> Add a driver for the EMIF SDRAM controller used in Texas Instrume=
nt SoCs
>> >>
>> >> EMIF is an SDRAM controller that supports, based on its revision,
>> >> one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds suppor=
t
>> >> for LPDDR2.
>> >>
>> >> The driver supports the following features:
>> >> - Calculates the DDR AC timing parameters to be set in EMIF
>> >> =A0 registers using data from the device data-sheets and based
>> >> =A0 on the DDR frequency. If data from data-sheets is not availab=
le
>> >> =A0 default timing values from the JEDEC spec are used. These
>> >> =A0 will be safe, but not necessarily optimal
>> >> - API for changing timings during DVFS or at boot-up
>> >> - Temperature alert configuration and handling of temperature
>> >> =A0 alerts, if any for LPDDR2 devices
>> >> =A0 * temperature alert is based on periodic polling of MR4 mode
>> >> =A0 =A0 register in DDR devices automatically performed by hardwa=
re
>> >> =A0 * timings are de-rated and brought back to nominal when
>> >> =A0 =A0 temperature raises and falls respectively
>> >> - Cache of calculated register values to avoid re-calculating
>> >> =A0 them
>> >>
>> >> The driver will need some minor updates when it is eventually
>> >> integrated with Dynamic Voltage and Frequency Scaling (DVFS).
>> >> This can not be done now as DVFS support is not available in
>> >> the mainline yet.
>> >>
>> >> Discussions with Santosh Shilimkar <santosh.shilimkar@ti.com>
>> >> were immensely helpful in shaping up the interfaces. Vibhore Vard=
han
>> >> <vvardhan@gmail.com> did the initial code snippet for thermal
>> >> handling.
>> >>
>> >> Testing:
>> >> - The driver is tested on OMAP4430 SDP.
>> >> - The driver in a slightly adapted form is also tested on OMAP5.
>> >> - Since mainline kernel doesn't have DVFS support yet,
>> >> =A0 testing was done using a test module.
>> >> - Temperature alert handling was tested with simulated interrupts
>> >> =A0 and faked temperature values as testing all cases in real-lif=
e
>> >> =A0 scenarios is difficult.
>> >> - Tested the driver as a module
>> >>
>> >> Cc: Greg KH <greg@kroah.com>
>> >
>> > This all looks good to me now, thanks for reworking this.
>> >
>> > So, do you want me to take this through my "driver" tree to get to=
 Linus
>> > for 3.5, or do you want it to go through somewhere else?
>> >
>> > If somewhere else, that's fine with me, consider this an:
>> > =A0 =A0 Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >
>> > If you want me to take it, just let me know, whichever you prefer =
is
>> > fine with me.
>> >
>> Can you take this one through your 3.5 driver tree please ?
>> Thanks for help.
>
> Ok, all now applied.
>
Thanks !!

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
