From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v1] OMAP: GPIO: Correct IP version message during boot
Date: Mon, 20 Dec 2010 15:49:05 -0800
Message-ID: <87zks02efi.fsf@deeprootsystems.com>
References: <1292508586-21651-1-git-send-email-charu@ti.com>
	<8739pxhdcz.fsf@deeprootsystems.com>
	<AANLkTimUrDAR1Wc4oJf74iYKhpxHKkGKLQOEuSNpcBXo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:37506 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933313Ab0LTXtL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 18:49:11 -0500
Received: by gwb20 with SMTP id 20so2418613gwb.1
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 15:49:10 -0800 (PST)
In-Reply-To: <AANLkTimUrDAR1Wc4oJf74iYKhpxHKkGKLQOEuSNpcBXo@mail.gmail.com>
	(Charulatha Varadarajan's message of "Fri, 17 Dec 2010 09:15:03
	-0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, balbi@ti.com

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Kevin,
>
> On Thu, Dec 16, 2010 at 11:49, Kevin Hilman <khilman@deeprootsystems.=
com> wrote:
>> "Varadarajan, Charulatha" <charu@ti.com> writes:
>>
>>> With the commit 9a748053f5f58a77cd71864f1d7b804175b0e47d whose subj=
ect is
>>> "OMAP: GPIO: Make omap_gpio_show_rev bank specific" (see [1]),
>>> the IP version information for all the banks are shown during bootu=
p,
>>> but it does not show the bank number.
>>>
>>> Use dev_info instead of printk in omap_gpio_show_rev() so that the
>>> bank id is displayed along with the IP version
>>>
>>> [1] http://www.spinics.net/lists/arm-kernel/msg105872.html
>>
>> A related question, the commit above also changed the GPIO revision
>> display from one-time to once per bank. =C2=A0Do we need to know the=
 GPIO HW
>> revision for each bank, or can we assume it's the same for all banks=
?
>
> The IP version is the same for all the gpio banks in all OMAP2+ CPUs.
> But I am not sure about OMAP16xx.
>

OK, then I suggest we switch this back to just printing the GPIO
revision once.   Maybe after all banks are found, just print the
revision for bank 1.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
