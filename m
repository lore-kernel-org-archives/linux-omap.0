From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Date: Mon, 18 Jun 2012 18:37:35 +0530
Message-ID: <CAJe_ZhdoEjyf0ejjsJJpznt83bTJTR0UW3aqaYAZdcm01GBp_A@mail.gmail.com>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
	<1340007094.1859.3.camel@lappyti>
	<CAJe_ZhdhBre8DUVNpawF6X5P+QSiMarkt3WUvbJ=RPcmpX3TPA@mail.gmail.com>
	<1340016865.4012.10.camel@deskari>
	<CAJe_ZhfJV6kYvSkU+4RGywv80A47=CxnoCy2rr-x=c2LFDGb7A@mail.gmail.com>
	<1340022276.4012.23.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43625 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2FRNHg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 09:07:36 -0400
Received: by lbbgm6 with SMTP id gm6so4282442lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 06:07:35 -0700 (PDT)
In-Reply-To: <1340022276.4012.23.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On 18 June 2012 17:54, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-06-18 at 17:16 +0530, Jassi Brar wrote:

>> So preferably I would move request_threaded_irq() to after
>> hdmi_check_hpd_state() in ti_hdmi_4xxx_phy_enable() =A0and convert t=
he
>
> No, you can't move the check. If you move it, the HPD state could cha=
nge
> between the check and the request_irq, and we'd miss it.
>
Wouldn't we then get an irq, and hence another hdmi_check_hpd_state(), =
for that?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
