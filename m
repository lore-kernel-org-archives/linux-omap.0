From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] dspbridge: reorganize initialization and probe
Date: Wed, 9 Jun 2010 12:28:59 +0300
Message-ID: <AANLkTik1fLQMSGEZb3RXzNeV6mXaDESkj_pLkhheRrAb@mail.gmail.com>
References: <1276044493-23003-1-git-send-email-omar.ramirez@ti.com>
	<AANLkTil4gAHQcEdAedxamD9mi5d-0CxGLqP_8h9vY77j@mail.gmail.com>
	<1276073342.10359.0.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56896 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab0FIJ3A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 05:29:00 -0400
Received: by bwz11 with SMTP id 11so1484133bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Jun 2010 02:28:59 -0700 (PDT)
In-Reply-To: <1276073342.10359.0.camel@chotu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>

On Wed, Jun 9, 2010 at 11:49 AM, Ameya Palande <ameya.palande@nokia.com> wrote:
> On Wed, 2010-06-09 at 09:25 +0200, ext Felipe Contreras wrote:
>> On Wed, Jun 9, 2010 at 3:48 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> > Split the functions to have cleaner error handling paths, this
>> > will aslo cover a case where bridge initialization has failed but
>> > device entry is still available which leads to unknown behavior.
>>
>> Great, I was wondering why this was not the case.
>>
>> Now that you are on this, do you know if there's something missing in
>> order to automatically load the module when somebody tries to open
>> /dev/DspBridge?
>
> I thought /dev/DspBridge will only appear if you load the module ;)

Kind of...
$ sudo touch /dev/DspBridge
See? I have dspbridge on my laptop ;)

I think it's possible to have udev rules that create the file, and
automatically load the module when accessed, but I don't know much
about udev.

-- 
Felipe Contreras
