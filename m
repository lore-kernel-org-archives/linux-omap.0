From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Re: [Q] No message from Kernel (Howto start debug?)
Date: Fri, 29 Jul 2011 12:20:50 +0200
Message-ID: <CAACX+R29sogiU3PkNf+doFEWewAqcsT6Hj4HTa10rk4+WR+5Dg@mail.gmail.com>
References: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
	<20110728132629.GH9069@legolas.emea.dhcp.ti.com>
	<CAACX+R0-vUP1z9DoS69iv2gX=YCKanousEHATzot0sSi-S9cEQ@mail.gmail.com>
	<20110729094439.74156e05@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59108 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014Ab1G2KUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 06:20:50 -0400
Received: by qwk3 with SMTP id 3so1754775qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Jul 2011 03:20:50 -0700 (PDT)
In-Reply-To: <20110729094439.74156e05@myhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tapani Utriainen <tapani@technexion.com>, Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org

2011/7/29 Tapani Utriainen <tapani@technexion.com>:
> On Thu, 28 Jul 2011 16:18:51 +0200
> Arno Steffen <arno.steffen@googlemail.com> wrote:
>
>> That has been good points. I've tried both, but with no result so far.
>>
>
> Try appending earlyprintk=${console} to your bootargs (where ${console}
> is your console string, e.g. ttyO0,115200n8 )
>
> ---
> Tapani Utriainen, PhD
> Senior Software Engineer
> TechNexion Ltd, www.technexion.com
>
>

Tried this without a change. I really think this is a machine-id problem.
So although I have done same changes for my board as in my previous 33
kernel, it might be not enough to cover the machine-id. Maybe I can
overule this for test to find out the source of this misbehaviour.
The problem is already before the first debug messages are coming.
Sricharan is right, first the message uncompress has to be printed.
Thanks
- Arno
