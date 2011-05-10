From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
Date: Tue, 10 May 2011 16:25:19 +0530
Message-ID: <BANLkTikjm7th9mv9MOBdMT7j6QPo5Ke7Xw@mail.gmail.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
	<alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com>
	<BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
	<alpine.DEB.2.00.1105061549150.30136@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:56656 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445Ab1EJKzV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 06:55:21 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so6759874bwz.5
        for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 03:55:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1105061549150.30136@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi,

On Sat, May 7, 2011 at 3:19 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Thu, 21 Apr 2011, Gulati, Shweta wrote:
>
>> Yes, but in current code clk_set_rate of dpll3_m2 -
>> 'omap3_core_dpll_m2_set_rate'
>> doesn't update clk.rate, I will submit patch fixing that bug and wil=
l
>> make sure that
>> set_rate of all clocks should update clk.rate
>
> Ping. =A0Do you plan to post this soon? =A0This should be a trivial p=
atch.
Sorry for the delay, I will post today.
> - Paul
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
