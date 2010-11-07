From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 6/7] omap: mailbox: fix detection for previously
 supported chips
Date: Sun, 7 Nov 2010 23:05:10 +0200
Message-ID: <AANLkTikw+46=41pn8Tq1pn7C3ESydasmqA9wfk2SSh4L@mail.gmail.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
	<1289006244-27147-7-git-send-email-omar.ramirez@ti.com>
	<4CD59A56.4070003@ti.com>
	<AANLkTin+oBj6CTpWKB9ZBYRVjR_8_tPcY_Y4+T5PecRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49747 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab0KGVFN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 16:05:13 -0500
Received: by bwz11 with SMTP id 11so4231543bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 13:05:12 -0800 (PST)
In-Reply-To: <AANLkTin+oBj6CTpWKB9ZBYRVjR_8_tPcY_Y4+T5PecRA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Nov 7, 2010 at 5:15 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> On Sat, Nov 6, 2010 at 1:11 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
>>> -#if defined(CONFIG_ARCH_OMAP3430)
>>> +#if defined(CONFIG_ARCH_OMAP3)
>>
>> Ideally you should get rid of all the CONFIG_ARCH_OMAPXXX or cpu_is_omap in
>> that code. This is a driver, it should be generic.
>> If you have to handle differences between OMAP version, please do that in
>> the devices, not in the driver.
>>
>> This patch just contains a few of them, but the original mailbox.c file is
>> full of that kind of test.
>> I know that you are not the original writer of this code, but since the
>> clean it, it will be good to remove all the legacy code.
>
> I mentioned it in the cover-letter, I should have put it here too, my bad.
>
> <quote>
> This is meant as a short term solution until proper cleanup is done,
> as suggested in:
>
> http://marc.info/?l=linux-arm-kernel&m=128534253231481&w=2
> </quote>
>
> Does nobody care that the driver is not working right now for some
> chips (since it was working before!!) and are willing to wait for more
> time until the proper cleanup is done?
>
> For me it is a hassle, because if I need to do something on 3630 I
> have to merge this patch, then apply what I'm working into, then
> remove the patch, apply everything again to see no dependencies are
> there, then send.

Huh? The mailbox is working for me on tidspbridge on 2.6.37-rc1.

-- 
Felipe Contreras
