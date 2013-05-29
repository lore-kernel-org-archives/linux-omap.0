From: Jon Hunter <jgchunter@gmail.com>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Wed, 29 May 2013 23:41:52 +0100
Message-ID: <51A68430.1050102@gmail.com>
References: <20130516180933.GG5600@atomide.com> <20130516210006.GA31836@blackmetal.musicnaut.iki.fi> <20130516214430.GN5600@atomide.com> <20130520174621.GI10378@atomide.com> <20130521173936.GE31836@blackmetal.musicnaut.iki.fi> <519BCCEC.8010303@gmail.com> <20130522212054.GG31836@blackmetal.musicnaut.iki.fi> <519E67AD.6070702@gmail.com> <20130526190710.GA3345@blackmetal.musicnaut.iki.fi> <51A4FAA1.5060504@gmail.com> <20130529185518.GB3345@blackmetal.musicnaut.iki.fi> <51A67323.7030906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:48862 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab3E2Wlz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 18:41:55 -0400
Received: by mail-wi0-f173.google.com with SMTP id hi5so4002957wib.0
        for <linux-omap@vger.kernel.org>; Wed, 29 May 2013 15:41:54 -0700 (PDT)
In-Reply-To: <51A67323.7030906@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, linux-arm-kernel@lists.infradead.org


On 29/05/13 22:29, Jon Hunter wrote:
> 
> On 29/05/13 19:55, Aaro Koskinen wrote:
>> Hi,
>>
>> On Tue, May 28, 2013 at 07:42:41PM +0100, Jon Hunter wrote:
>>> Care to share the log?
>>
>> Below are three logs from 3.10-rc3 / Nokia 770. I did not even compile
>> Retu this time, as it has nothing to do with GPIO IRQs being broken
>> on OMAP1.
> 
> That's not entirely true. v3.10-rc3 is booting fine on an osk5912 and
> ethernet is working which is using a gpio for interrupts and it is
> getting interrupts.

Scratch that. It appears that the osk is using gpio-0 as the interrupt
and so it is only by chance this is working. I agree it is broken and so
Tony's fix is needed.

Jon


