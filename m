From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 5/7] Serial: OMAP: add runtime pm support for omap-serial driver
Date: Wed, 9 Mar 2011 18:33:34 +0530
Message-ID: <AANLkTi=wqZc2UCNcj-DyuTcVBwaKiddsxdBF3XEwkhTH@mail.gmail.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
 <1298903958-6496-6-git-send-email-govindraj.raja@ti.com> <87r5am499h.fsf@ti.com>
 <AANLkTim35McK1cFFEXyS49D6b8CT+4pQfmKAswOn3e7_@mail.gmail.com>
 <87hbbdjc7y.fsf@ti.com> <alpine.DEB.2.00.1103081849360.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36160 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab1CINDz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 08:03:55 -0500
In-Reply-To: <alpine.DEB.2.00.1103081849360.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Wed, Mar 9, 2011 at 7:32 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi Govindraj,
>
> what also would be good to find out is why the UART is apparently sen=
ding
> asynchronous wakeups even when the driver doesn't set
> SCR_REG.RX_CTS_WU_EN. =A0This seems contrary to the expectation that =
34xx
> TRM vZH section 17.4.4.1.4.1 "Wake-up Interrupt" sets. =A0Could you p=
lease
> clarify under which circumstances the RX_CTS_WU_EN bit is used? =A0I =
suppose
> that, given that it's also mentioned under section 17.4.5.1.1 "Module
> Power Savings", it might only be used when SLEEP_MODE is enabled.
>

AFAIK, sleep_mode is used only for uart internal power saving
options if fifo's are empty which inturn can stop uart internal baud cl=
ock.
To enable back uart baud clock and start uart internal activity it
will depend on RX_CTS_WU_EN from scr to restart uart_baud_clock.

=46or system level powers saving like cutting uart_fclks
wakeup will depend on WER reg for wakeup event or io-pad
wakeup depending on power state.
Since I am cutting fclks directly I am depending on
WER reg wakeup events.

--
Thanks,
Govindraj.R


>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
