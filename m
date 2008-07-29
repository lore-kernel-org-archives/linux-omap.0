From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH 0/4] OMAP: MENELAUS: Improvements on menelaus
Date: Tue, 29 Jul 2008 20:57:21 +0200
Message-ID: <fb249edb0807291157v40f4c0e0vf0e35b1beb39cd3b@mail.gmail.com>
References: <488F48E3.2060504@indt.org.br> <20080729183717.GB7275@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:46000 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759074AbYG2S5W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 14:57:22 -0400
Received: by an-out-0708.google.com with SMTP id d40so580and.103
        for <linux-omap@vger.kernel.org>; Tue, 29 Jul 2008 11:57:21 -0700 (PDT)
In-Reply-To: <20080729183717.GB7275@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Carlos Aguiar <carlos.aguiar@indt.org.br>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi,

2008/7/29 Felipe Balbi <me@felipebalbi.com>:
> On Tue, Jul 29, 2008 at 12:44:19PM -0400, Carlos Aguiar wrote:
>> Hi Tony and folks,
>>
>> This patch series proposes some improvements on menelaus code.
>>
>> Basically it makes menelaus to use macros instead of some magic constant
>> numbers, making menelaus code more legible. The menelaus header was
>> moved to include/linux/i2c and register map (including the macros
>> created) were moved to include/linux/i2c/menelaus.h
>>
>> Tested with MMC on N800 and looks fine.
>
> They look quite ok. How about syncing l-o menelaus with mainline via
> lm-sensors mailing list and discuss all these there as well ??

How about renaming it to twl92230c before submitting upstream?  As far
as I can tell the name menelaus appears only in linux and makes it
hard to associate with the real hardware.  Does someone know why was
it renamed that way?

Regards
