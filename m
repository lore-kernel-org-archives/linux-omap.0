From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/1] mfd: omap-usb-host: Fix USB device detection problems
 on OMAP4 Panda
Date: Mon, 02 Dec 2013 14:39:00 +0100
Message-ID: <529C8D74.10007@linutronix.de>
References: <1385730118-26402-1-git-send-email-rogerq@ti.com>	<1385730118-26402-2-git-send-email-rogerq@ti.com> <CAOf5uwmEkzFd=e3j8m8=qdTCAMkk_-DPw0fTm=7Vzy0PbE2oDQ@mail.gmail.com> <529C55DF.3000808@ti.com> <529C76AF.10106@linutronix.de> <529C7922.5000601@ti.com> <529C854F.3010101@linutronix.de> <529C8CBD.4070003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <529C8CBD.4070003@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Felipe Balbi <balbi@ti.com>, lee.jones@linaro.org, sameo@linux.intel.com, tomi.valkeinen@ti.com, Stefan Roese <sr@denx.de>, ljkenny.mailinglists@gmail.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/02/2013 02:35 PM, Roger Quadros wrote:
>> It refers to "Errata Id:i660" why it is required. Once you figured what
>> why it has been added you could have an idea if it is okay to remove it
>> and if the reset you do here might lead to it (I dunno).
>>
> 
> Keshava no longer works @TI. I have no other means to check why it was added
> other than doing dome tests and making sure nothing breaks if we remove it.
> 
> So far, things are going fine for about 50 or so boots divided between OMAP3 and 4
> platforms. If more people can test and give feedback it'd be great.

Hmm. Can't you lookup the errata he revers to?

> cheers,
> -roger
> 

Sebastian
