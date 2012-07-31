From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Tue, 31 Jul 2012 13:57:59 +0530
Message-ID: <CAJe_Zhd4ubkfMRmVNt734N0Sc3+7OfXrgSPq-fUSH+uQfQ5RzA@mail.gmail.com>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
	<CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
	<1343721101.4685.35.camel@lappyti>
	<CAJe_Zheg_fpnRb+eLt5SQioSUXp=PFcPz-vWC-RL3_Mh35VBdA@mail.gmail.com>
	<1343722450.4685.37.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51041 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab2GaI17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 04:27:59 -0400
Received: by vbbff1 with SMTP id ff1so5500051vbb.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 01:27:59 -0700 (PDT)
In-Reply-To: <1343722450.4685.37.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Raphael Assenat <raph@8d.com>, linux-omap@vger.kernel.org, Archit Taneja <a0393947@ti.com>

On 31 July 2012 13:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Tue, 2012-07-31 at 13:33 +0530, Jassi Brar wrote:
>> On 31 July 2012 13:21, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>
>> > 2) Have the configuration for countless panels specified in the DT data
>> >
>> Why should a DT blob for a board contain more than 1 panel configuration?
>
> I meant the DT data generally, for all boards.
>
If you mean : Why have the configuration (those 15 integers) of the
panel on a board specified in board.dtb?
Well, that is an important purpose of DT - moving board specific
parameters, on which a generic code works, out of kernel (I am
refraining from preaching the goodness of that).
