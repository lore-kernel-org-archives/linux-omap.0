From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: omap5: build opp4xxx_data.c
Date: Tue, 25 Jun 2013 13:56:09 -0700
Message-ID: <87a9mducye.fsf@linaro.org>
References: <201306212229.54238.arnd@arndb.de> <20130621204250.GA16139@kahuna>
	<alpine.DEB.2.02.1306251918590.14373@utopia.booyaka.com>
	<51C9F595.3060609@ti.com> <20130625195751.GA6529@kahuna>
	<51C9F993.6050109@ti.com>
	<CAGo_u6rQG7h2aPSErwKR1H7PYE5QdxXU3Dd5z13-rPkbVtkcUw@mail.gmail.com>
	<51C9FC97.1020502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64119 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab3FYU4N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jun 2013 16:56:13 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so13239319pad.4
        for <linux-omap@vger.kernel.org>; Tue, 25 Jun 2013 13:56:12 -0700 (PDT)
In-Reply-To: <51C9FC97.1020502@ti.com> (Santosh Shilimkar's message of "Tue,
	25 Jun 2013 16:24:55 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, "J, KEERTHY" <j-keerthy@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Tuesday 25 June 2013 04:17 PM, Nishanth Menon wrote:
>> On Tue, Jun 25, 2013 at 3:12 PM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>>>
>>> Well having voltage data in voltage domain was not my decision ;-)
>>> Instead of creating another set of dummy data, I just used what
>>> is out there(OMAP4) with clear comment that data needs to be updated.
>>> I don't see any problem in this considering we have devices booting
>>> and working nicely for OMAP5
>> I really wish the OMAP5 devices(the latest ones from Fab) I have would
>> like to function at OMAP4 configurations! Unfortunately the devices
>> tend to follow the data manual for OMAP5.
>> *if* there is no need for it to boot, I suggest removing it.
>> 
> I don't understand you. For OMAP5, that data without voltage
> controller support doesn't do anything bad. Since there was some
> dependency of voltage domain association whit PD's, I have to keep
> that. I never claimed that OMAP4 settings would work for OMAP5
> in absolute terms.
>
> Feel free to post a patch with right data which you seems to have.
> I don't mind you removing that data as long as the device
> continues to boot. Patch welcome.

Thanks to Rajendra's cleanup, I don't think we need dummy data anymore:

   http://marc.info/?l=linux-omap&m=137147503827947&w=2

That series is queued for v3.11.

Kevin
