From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3 0/4] OMAP serial device tree support
Date: Wed, 14 Dec 2011 20:11:55 +0530
Message-ID: <CAAL8m4yA_pdaL6_reEtcvGSZBHw5XdrcVLevTNL2GON09174=w@mail.gmail.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42231 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab1LNOmR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 09:42:17 -0500
In-Reply-To: <1323863746-18145-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, tony@atomide.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com

Hi Rajendra,

On Wed, Dec 14, 2011 at 5:25 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> v3 is rebased on top of the latest serial runtime
> patches[1] and boot tested with/without DT on OMAP4
> SDP and OMAP4 Panda boards.
>
> Patches can be found here..
> git://gitorious.org/omap-pm/linux.git for-dt/serial
>
> I also had to pull in a fix[2] for DT testing (already in linux-omap
> master) which was missing as the serial runtime branch[1]
> was based on an older master commit.
>
> Changes in v3:
> -1- Rebased on latest serial runtime patches
> -2- Minor typr fixes
>
> Changes in v2:
> -1- Got rid of binding to define which uart is console
> -2- Added checks to default clock speed to 48Mhz
> -3- Added compatible for each OMAP family
> -4- Used of_alias_get_id to populate port.line
>
> [1] git://gitorious.org/runtime_3-0/runtime_3-0.git for_3_3/lo_rc4_uartruntime
> [2] http://www.spinics.net/lists/arm-kernel/msg150751.html
>

I merged this patch series to a tmp_intg branch [1]
having uart runtime changes and sanity tested on
3430sdp/zoom3/panda seems fine.

--
Thanks,
Govindraj.R

[1]:
git://gitorious.org/runtime_3-0/runtime_3-0.git
for_3_3/tmp_rc4_uart_pm_intg
