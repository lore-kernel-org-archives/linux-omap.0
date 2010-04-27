From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: OMAP3: Linux Without a Boot Loader?
Date: Mon, 26 Apr 2010 20:31:57 -0500
Message-ID: <4BD63E8D.1090701@gmail.com>
References: <4BD61F7D.3060208@ti.com> <i2ra46a26fd1004261722sd0c56aafj90275e805502e9db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50032 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab0D0BcB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 21:32:01 -0400
Received: by gyg13 with SMTP id 13so6526789gyg.19
        for <linux-omap@vger.kernel.org>; Mon, 26 Apr 2010 18:32:00 -0700 (PDT)
In-Reply-To: <i2ra46a26fd1004261722sd0c56aafj90275e805502e9db@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Ungerer <gerg@snapgear.com>

On 04/26/2010 07:22 PM, Juha Kuikka wrote:
> On Mon, Apr 26, 2010 at 4:19 PM, Nishanth Menon<nm@ti.com>  wrote:
>>
>> The final image looks as follows:
>>         +---------------------+
>>         | Configuration       |
>>         | Header              |
>>         +---------------------+
>>         | "Sty"               |
>>         +---------------------+
>>         | kernel piggy        |
>>         | bzImage             |
>>         +---------------------+
>>
> Looks very interesting! I was thinking of trying something like this
> after ELC but unfortunately real work got the better of me.
>
> This Configuration Header stuff looks very similar to what TI's
> Davinci-chips use. They call it AIS but from a short dive into
> omap-u-boot-utils it is very similar, encoded commands to mask ROM
> code to initialize HW and load image(s).
>
> Now I need to find some time to do this with the Beagle.
>
> This may be a stupid question but is the CH format documented somewhere?

Yep, I had blogged about it some time back:
http://nishanthmenon.blogspot.com/2009/05/configuration-header-no-more-x-loader.html
You can find more about CH and references there, and yes, Beagle is one 
of the first platforms I had working :)

Regards,
Nishanth Menon
