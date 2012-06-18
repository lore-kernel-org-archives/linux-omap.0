From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Date: Mon, 18 Jun 2012 17:16:28 +0530
Message-ID: <CAJe_ZhfJV6kYvSkU+4RGywv80A47=CxnoCy2rr-x=c2LFDGb7A@mail.gmail.com>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
	<1340007094.1859.3.camel@lappyti>
	<CAJe_ZhdhBre8DUVNpawF6X5P+QSiMarkt3WUvbJ=RPcmpX3TPA@mail.gmail.com>
	<1340016865.4012.10.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42596 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750792Ab2FRLqa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 07:46:30 -0400
Received: by lahd3 with SMTP id d3so3430582lah.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 04:46:28 -0700 (PDT)
In-Reply-To: <1340016865.4012.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On 18 June 2012 16:24, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-06-18 at 15:42 +0530, Jassi Brar wrote:

>> BTW, coming to think about it, I am not sure what we need the
>> spin_lock_irqsave() protection for in hdmi_check_hpd_state() ? =A0It
>> can't control HPD gpio state change and hdmi_set_phy_pwr() seems too
>> expensive and is already unprotected elsewhere.
>
> It's needed when enabling the hdmi output. In phy_enable() the irq is
> requested first, and then the phy_enable() runs hdmi_check_hpd_state(=
).
> So there's a chance to run hdmi_check_hpd_state() from both
> hpd-interrupt and phy_enable() at the same time.
>
> The hdmi_set_phy_pwr() is not called in many places, but I think ther=
e's
> indeed a problem there. It is called after free_irq(), but I think
> (guess) the irq handler could still be running after free_irq. So tho=
se
> should be protected by the same spinlock too.
>
You know TI HDMI better than I do, so I assume your concerns are valid.
So preferably I would move request_threaded_irq() to after
hdmi_check_hpd_state() in ti_hdmi_4xxx_phy_enable()  and convert the
spin_lock_irqsave() in hdmi_check_hpd_state() to some mutex (we don't
want irqs disabled so long as it takes for phy to power on/off).
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
