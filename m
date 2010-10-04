From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: tidspbridge broken?
Date: Mon, 4 Oct 2010 21:24:18 +0300
Message-ID: <AANLkTi=Z1Ufe+Q5dHcMts5rcoTeR_S9W8DFUU58G-yRx@mail.gmail.com>
References: <AANLkTi=hD1m0jC64KW7gHdywd=2GseX8gqNwPTHOh6s2@mail.gmail.com>
	<27F9C60D11D683428E133F85D2BB4A5304680CC90F@dlee03.ent.ti.com>
	<AANLkTimH0+jeFx+zUh6u_uzqhL+rB5W6s3PYOatHMB6b@mail.gmail.com>
	<27F9C60D11D683428E133F85D2BB4A5304680CCA10@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46219 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab0JDSYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 14:24:20 -0400
Received: by bwz11 with SMTP id 11so3844404bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 11:24:18 -0700 (PDT)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5304680CCA10@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>, "Menon, Nishanth" <nm@ti.com>, "ohad@wizery.com" <ohad@wizery.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>

On Mon, Oct 4, 2010 at 8:34 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> Felipe Contreras wrote:
> ...
>>
>> Anyway, first, I think I tried a version similar to that one, and
>> doesn't apply on mainline any more, also, bootmem doesn't seem to be
>> working on ARM either, so I had to move to memblock, and third, I
>> don't think that platform device is correct since it depends on the
>> headers of a driver.
>
> AFAIK, bootmem is going down (http://marc.info/?l=linux-omap&m=126955999303922&w=2), I succesfully tried LMB a while back when rebasing but for the latest RCs I haven't seen it around.

It's called memblock now. And yeah, bootmem is going down, but it
should still work right now.

-- 
Felipe Contreras
