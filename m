From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v4 4/5] OMAP: mailbox: build device using omap_device/omap_hwmod
Date: Thu, 16 Dec 2010 08:21:54 -0600
Message-ID: <AANLkTi=VyX4M6j7Zd-ZJq+djs8AoJ_dMaWmPVX2eiFoD@mail.gmail.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
	<1292482079-2226-5-git-send-email-omar.ramirez@ti.com>
	<AANLkTik4K3LEovr-wJiv_PG+ivHNj8hxPT7QPua-ytVf@mail.gmail.com>
	<20101216084446.GB10883@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33643 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753670Ab0LPOVy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 09:21:54 -0500
Received: by mail-gw0-f54.google.com with SMTP id 21so2206384gwj.27
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 06:21:54 -0800 (PST)
In-Reply-To: <20101216084446.GB10883@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 16, 2010 at 2:44 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 16, 2010 at 02:08:11PM +0530, Varadarajan, Charulatha wro=
te:
>> > + =A0 =A0 =A0 oh =3D omap_hwmod_lookup("mailbox");
>> > + =A0 =A0 =A0 if (!oh) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: unable to find hwmod\n",=
 __func__);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 od =3D omap_device_build("omap-mailbox", -1, oh,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_latencies, ARRA=
Y_SIZE(mbox_latencies),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0);
>> > + =A0 =A0 =A0 if (!od) {
>>
>> Check for IS_ERR(od).
>>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: could not build device\n=
", __func__);
>
> If you have an API which returns errors, and you're bothering to prin=
t
> something when an error occurs, it's often useful to print the return=
ed
> error code, so that people can find out _why_ the error occurred.
>

Agree.

Thanks,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
