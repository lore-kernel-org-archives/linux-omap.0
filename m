From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v3 0/6] ARM: OMAP2+: hwmod and SERIAL: Remove sysc handling from driver
Date: Fri, 17 May 2013 07:29:04 -0700
Message-ID: <87txm1smrz.fsf@linaro.org>
References: <1368629322-3170-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1305161831390.21357@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33410 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317Ab3EQO3H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 10:29:07 -0400
Received: by mail-pd0-f170.google.com with SMTP id 15so626385pdi.1
        for <linux-omap@vger.kernel.org>; Fri, 17 May 2013 07:29:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1305161831390.21357@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 16 May 2013 18:32:43 +0000 (UTC)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, nm@ti.com

Hi Paul,

Paul Walmsley <paul@pwsan.com> writes:

> On Wed, 15 May 2013, Rajendra Nayak wrote:
>
>> OMAP UART IP needs manual idle modes based on functional state of the
>> IP. Currently this is handled by the driver with function pointers
>> implemented in platform code.
>> 
>> This however breaks in case of device tree because of missing
>> idle handling. 
>> 
>> The series tries to address the issue and tries to remove complete
>> sysc handling from serial driver.
>
> These look good to me.  Will queue them for v3.10-rc once they pass local 
> testing here.

I reviewed and tested v2 of this (Rajendra forgot to add the tags in
v3) and also just sanity tested v3 of this on 4430/panda DT boot to
verify the console issue is resolved.  Feel free to add:

Reviewed-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Kevin Hilman <khilman@linaro.org>  # OMAP4/Panda

Kevin
