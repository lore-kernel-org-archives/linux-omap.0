From: Vladimir <vovan888@gmail.com>
Subject: Re: [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa driver.
Date: Mon, 25 Sep 2006 15:42:12 +0400
Message-ID: <ce55079f0609250442x5638a93fuac95c65a54a0927@mail.gmail.com>
References: <44E51565.6020505@cc.jyu.fi> <20060905151808.GC18073@atomide.com>
	 <44FF2A6D.3000500@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751414AbWIYLmO@vger.kernel.org>
In-Reply-To: <44FF2A6D.3000500@cc.jyu.fi>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lamikr@cc.jyu.fi
Cc: tony@atomide.com, OMAP-Linux <linux-omap-open-source@linux.omap.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> 1) As we do not yet have any kind of multiplexing support to gsm module
> (currently directly accesing dev/ttyS1 for at commands)
> our phone app is not able to run simultaneously with the ppp. I am not
> sure should I resolve this in the kernel space or user space.
>

I work on getting linux running on Siemens SX1 mobile phone.
and I use GSM multiplexer daemon from here -
http://developer.berlios.de/projects/gsmmux/
it works fine for me.
