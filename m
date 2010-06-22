From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [pm-wip/uart][PATCH 3/5 v2] OMAP3: serial: Fix uart4 handling for
	3630
Date: Tue, 22 Jun 2010 20:25:09 +0530
Message-ID: <AANLkTinc_UeaArVDogzSldW5SWfBPHE-h0pAOCkSRNEr@mail.gmail.com>
References: <2232.10.24.255.18.1276697648.squirrel@dbdmail.itg.ti.com>
	<87typ1jpt8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41894 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481Ab0FVOzK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 10:55:10 -0400
Received: by gwaa12 with SMTP id a12so1046872gwa.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 07:55:09 -0700 (PDT)
In-Reply-To: <87typ1jpt8.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

On Fri, Jun 18, 2010 at 3:15 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> This patch makes the following:
>> =A0- Adds missing wakeup padding register handling.
>> =A0- Fixes a hardcode to use PER module ONLY on UART3.
>> =A0- Muxmode usage needed for uart4 for 3630, for padconf
>> =A0 =A0wakeup on uart4_rx line. uart4_rx signal is available
>> =A0 =A0under mode-2 in gpmc_wait3. Thus have to ensure we are
>> =A0 =A0in right mux mode before accesing any padconf register.
>> =A0 =A0So ensure right mux mode for uarti padconf access.
>
> I think this mux-mode handling should be done as a separate patch wit=
h
> more description as exactly what problem this is solving.
>
> Presumably, whatever problem you're solving not unique to 3630 UART4
> as the UARTs on the other platforms can be muxed with other
> peripherals as well.
>
> Based on the way it's being mux'd (and continually re-mux'd) in this
> patch, it looks like the mux settings for that pin are being
> dynamically changed elsewhere in the code. =A0If that's the case, the=
n
> that should be better understood, and this code should likely re-mux
> to the original settings when its done.
>
> Kevin

Since padconf and mux_mode value is populated based on a cpu_check I
thought other platforms might not be affected

Actually uart4_rx in available under CONTROL_PADCONF_GPMC_WAIT2[31:16]
in mux_mode 2

I am not sure whether this gpmc line is used or not.

I was just trying to be cautious in read and write for uart4_rx
Ensuring that I am using right mux mode wrt uart
Yes I do agree that I can corrupt gpmc_wait2 padconf if used by other
peripheral.

So any thought how do we handle rx wakeup if not available as an
seperate padconf
as in this case uart4_rx
I mean if uart_rx_padconf is not available straight forward and
available under a muxmode

Regards,
Govindraj.R

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
