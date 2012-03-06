From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP3+: PM: VP: fix integer truncation error
Date: Tue, 6 Mar 2012 19:36:29 +0100
Message-ID: <CAMQu2gw5bZg1kw2-jrtAs4MTkaPPfDsimhwCWmZUCCe3rOu8rw@mail.gmail.com>
References: <1331058767-28933-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42930 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932085Ab2CFSgu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Mar 2012 13:36:50 -0500
Received: by mail-qy0-f178.google.com with SMTP id e14so3435427qcs.23
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 10:36:49 -0800 (PST)
In-Reply-To: <1331058767-28933-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, kevin <khilman@ti.com>, Jon <jon-hunter@ti.com>, Yuan Jiangli <jlyuan@motorola.com>

On Tue, Mar 6, 2012 at 7:32 PM, Nishanth Menon <nm@ti.com> wrote:
> From: Yuan Jiangli <jlyuan@motorola.com>
>
> commit 2f34ce81b8c05c900e45bd88595cc154f7bb5957
> (OMAP3: PM: Adding voltage driver support.)
> introduced runtime computation of waittime to handle all potential
> sys clocks available.
>
> In the voltage processor, the SPMSUpdateWait is calculated based on
> the slew rate and the voltage step (SMPSUpdateWait =3D slew rate *
> Voltage Step). After the voltage processor receives the SMPS_Ack
> signal, the Voltage Controller will wait for SMPSUpdateWait clock
> cycles for the voltage to settle to the new value. For all
> practical purposes, the waittime parameter is the OMAP hardware
> translation of what the slew rate on the PMIC is.
>
> As an example, with TPS62361 on OMAP4460,
> step_size =3D 10000
> slew_rate =3D 32000
> sys_clk_rate =3D 38400
>
> Our current computation results in the following:
> =A0=3D ((step_size / slew_rate) * sys_clk_rate) / 1000
> =A0=3D ((10000 / 32000) * 38400 / 1000
> =A0=3D 0
>
> Fix the same using DIV_ROUND_UP as an extra wait clock cycle
> is better than lesser clock cycle. For the above example, this
> translates to:
> =A0=3D (10000 * 38400) / (1000 * 32000)
> =A0=3D 12
>
> Change-Id: I0ee22e60555e1cfd6cc3dea7ee44d0584ce182b6
You don't need above gerrit change id in commit message.

Regardas
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
