From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC PATCH 1/5] Device Power: introduce power controller
Date: Thu, 6 Dec 2012 21:18:17 +0800
Message-ID: <CACVXFVMKYAANsNJKBZ90ThaJ7KNOTzpyvARGnNcHsVVczxyO4A@mail.gmail.com>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
	<1354460467-28006-2-git-send-email-tom.leiming@gmail.com>
	<50BB7BA9.4090902@linaro.org>
	<CACVXFVNfGZRE4y0+LpBixiMab2=QhOKCcRG_QEz-u7ZwuPnMvQ@mail.gmail.com>
	<50BF7B30.9050904@ti.com>
	<CACVXFVOiu5+M3A14Q-U2FiHYrBjAswp4Jv+Aybs_kV9DiWNHZw@mail.gmail.com>
	<CAJe_ZhcUV7mYaNSEw1kLe8-Ym6RcVEab-1-ZZMT20xsWAb=szQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAJe_ZhcUV7mYaNSEw1kLe8-Ym6RcVEab-1-ZZMT20xsWAb=szQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, Andy Green <andy.green@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 6, 2012 at 11:46 AM, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>> The patch can make usb port deal with the 'power controller' only, and make it
>> avoid to deal with regulators/clocks/... directly.
>>
> I am curious too, except for clocks and voltage supplies (regulators),
> what other external resources does a chip need ?

For example, one indicator LED which doesn't connect to the same power
domain might need to be triggered after the power switch state is changed.

Thanks,
-- 
Ming Lei
