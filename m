From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 3/5 v2] OMAP3: serial: Fix uart4 handling for  3630
Date: Tue, 22 Jun 2010 08:22:06 -0700
Message-ID: <87tyovks81.fsf@deeprootsystems.com>
References: <2232.10.24.255.18.1276697648.squirrel@dbdmail.itg.ti.com>
	<87typ1jpt8.fsf@deeprootsystems.com>
	<AANLkTinc_UeaArVDogzSldW5SWfBPHE-h0pAOCkSRNEr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:33976 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab0FVPWL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 11:22:11 -0400
Received: by pxi12 with SMTP id 12so2030125pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 08:22:10 -0700 (PDT)
In-Reply-To: <AANLkTinc_UeaArVDogzSldW5SWfBPHE-h0pAOCkSRNEr@mail.gmail.com> (Govindraj's message of "Tue\, 22 Jun 2010 20\:25\:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

Govindraj <govindraj.ti@gmail.com> writes:

> On Fri, Jun 18, 2010 at 3:15 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> This patch makes the following:
>>> =A0- Adds missing wakeup padding register handling.
>>> =A0- Fixes a hardcode to use PER module ONLY on UART3.
>>> =A0- Muxmode usage needed for uart4 for 3630, for padconf
>>> =A0 =A0wakeup on uart4_rx line. uart4_rx signal is available
>>> =A0 =A0under mode-2 in gpmc_wait3. Thus have to ensure we are
>>> =A0 =A0in right mux mode before accesing any padconf register.
>>> =A0 =A0So ensure right mux mode for uarti padconf access.
>>
>> I think this mux-mode handling should be done as a separate patch wi=
th
>> more description as exactly what problem this is solving.
>>
>> Presumably, whatever problem you're solving not unique to 3630 UART4
>> as the UARTs on the other platforms can be muxed with other
>> peripherals as well.
>>
>> Based on the way it's being mux'd (and continually re-mux'd) in this
>> patch, it looks like the mux settings for that pin are being
>> dynamically changed elsewhere in the code. =A0If that's the case, th=
en
>> that should be better understood, and this code should likely re-mux
>> to the original settings when its done.
>>
>> Kevin
>
> Since padconf and mux_mode value is populated based on a cpu_check I
> thought other platforms might not be affected

What I meant was that the UART pins on OMAP3 are also mux'd with other
peripherals, so if you're managing the mux for UART4, you should also
manage them for the other UARTs.

> Actually uart4_rx in available under CONTROL_PADCONF_GPMC_WAIT2[31:16=
]
> in mux_mode 2
>
> I am not sure whether this gpmc line is used or not.
>
> I was just trying to be cautious in read and write for uart4_rx
> Ensuring that I am using right mux mode wrt uart
> Yes I do agree that I can corrupt gpmc_wait2 padconf if used by other
> peripheral.
>
> So any thought how do we handle rx wakeup if not available as an
> seperate padconf
> as in this case uart4_rx

The board code should be muxing the UARTs at init time.  If there is a
need to dynamically manage the mux settings, then that is a separate
issue.

Kevin

> I mean if uart_rx_padconf is not available straight forward and
> available under a muxmode
>
> Regards,
> Govindraj.R
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --=20
> ---
> Regards,
> Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
