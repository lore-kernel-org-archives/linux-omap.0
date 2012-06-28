From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 20:48:13 +0530
Message-ID: <CAJe_ZhexDJcM0ZoDYM904G7JrT93vmQJYo6j1ZW4CmfFTDM9Pg@mail.gmail.com>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	<1340869729.5037.7.camel@deskari>
	<CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	<1340878461.5037.30.camel@deskari>
	<CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	<CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
	<1340881815.5037.53.camel@deskari>
	<4FEC47FA.1040801@linaro.org>
	<CAJe_Zhdkhu4TciiwGJB2Kz8oZp2RQNZfESSr5Cfv0R1MNn=r9A@mail.gmail.com>
	<1340896458.5037.131.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62047 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab2F1PSO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 11:18:14 -0400
Received: by lbbgm6 with SMTP id gm6so3228327lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 08:18:13 -0700 (PDT)
In-Reply-To: <1340896458.5037.131.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andy Green <andy.green@linaro.org>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com, patches@linaro.org

On 28 June 2012 20:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Thu, 2012-06-28 at 18:43 +0530, Jassi Brar wrote:
>
>> A quick reaction of my guts say, we simply enable 5V/HPD_IRQ during
>> probe and disable during remove.
>> HDMI enable/disable via /sysfs/ and HPD (de)assertion, switch only
>> HDMI_PHY on/off.
>> The user selecting "Autodetect and Configure" option would then equate
>> to "(un)loading" of the HDMI driver.
>> Not to mean a trivial job.
>
> One more thing I realized while thinking about this:
>
> While it could be argued that the power draw from having the tpd12s015
> always enabled is very small, I think it could matter. If you consider a
> phone with HDMI output, it's likely that the phone is locked 99% of the
> time. When the phone is locked, there's no need to keep the HDMI HPD
> enabled. So this could add to a considerable amount of power wasted, if
> the HPD was always enabled.
>
> At least I can't figure out a reason why one would want the HPD to work
> when the phone is locked. Also, I have never used the HDMI output on my
> phone, so I'd be glad if it was totally powered off if it gave me more
> standby hours =).
>
Of course, I don't suggest imposing any hard rule here.
All I suggest is make it platform dependent and provide a way from
user-space too to enable/disable HPD.
