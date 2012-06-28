From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 20:44:54 +0530
Message-ID: <CAJe_ZheBbj3qoECDokcxHsB4UOx354G5t_MfYiZ3UEm9xK=tqw@mail.gmail.com>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	<1340869729.5037.7.camel@deskari>
	<CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	<1340878461.5037.30.camel@deskari>
	<CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	<CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
	<1340881815.5037.53.camel@deskari>
	<4FEC47FA.1040801@linaro.org>
	<CAJe_Zhdkhu4TciiwGJB2Kz8oZp2RQNZfESSr5Cfv0R1MNn=r9A@mail.gmail.com>
	<1340890278.5037.91.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61324 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab2F1PO4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 11:14:56 -0400
Received: by bkcji2 with SMTP id ji2so2115991bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 08:14:55 -0700 (PDT)
In-Reply-To: <1340890278.5037.91.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andy Green <andy.green@linaro.org>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com, patches@linaro.org

On 28 June 2012 19:01, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Thu, 2012-06-28 at 18:43 +0530, Jassi Brar wrote:
>> On 28 June 2012 17:33, Andy Green <andy.green@linaro.org> wrote:
>
>> > If Jassi's alright with it we might have a go at implementing this, but can
>> > you define a bit more about how we logically tell DSS that we want to, eg,
>> > disable HDMI totally?
>> >
>> A quick reaction of my guts say, we simply enable 5V/HPD_IRQ during
>> probe and disable during remove.
>
> The problem with this is a feature of omapdss: we can have multiple
> displays for the same output, of which only one can be enabled at the
> same time. What this means is that you shouldn't (and in some cases
> can't) allocate or enable resources in probe that may be shared, because
> then the driver for both displays would try to allocate the same
> resource.
>
> Sure, this is not a problem for the HDMI configuration we are using now,
> but it's still against the panel model we have. Thus we should allocate
> resources only when the panel device is turned on, and release them when
> it's disabled.
>
> I do think the model is slightly broken, but that's what we have now.
> And I'm also not even sure how it should be fixed...
>
I won't press further with my Utopian ideas, but I think we need to
segregate 5V/HPD enabling from PHY enabling somehow. Because that is
already failing slow but otherwise perfectly legit displays (like
Andy's "HPD taking 700ms" TV)


> And also, as I said earlier, if you keep it enabled all the time, it'll
> eat power even if the user is never going to use HDMI.
>
> On a desktop I guess the power consumption wouldn't be an issue, but I
> do feel a bit uneasy about it on an embedded device.
>
As I said, it should be platform dependent. If a device doesn't have
HDMI port, the board file would not even have platform_enable. And if
it has, some user action should enable it while 'making the device
ready for new display'.
IOW, how do you envision an OMAP4 based tablet with HDMI port react to
display connections ?


>> HDMI enable/disable via /sysfs/ and HPD (de)assertion, switch only
>> HDMI_PHY on/off.
>> The user selecting "Autodetect and Configure" option would then equate
>> to "(un)loading" of the HDMI driver.
>
> HDMI cannot be currently compiled as a separate module. Although I think
> you can detach a device and a driver, achieving the same. Is that what
> you meant with unloading?
>
Yeah, I meant something to the effect of bringing HDMI driver to life.


> By the way, when the device is in system suspend, we surely won't detect
> the HPD even if we kept the HPD always enabled. So there we'll miss the
> HPD interrupt anyway, and the EDID cache would be invalid.
>
If omapdss already handles the possibility of display changed during
suspend, I think we should be good :)
