From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: musb-hdrc: "Vbus off, timeout 1100 msec" message does not belong
 in sysfs
Date: Fri, 10 Jul 2015 09:17:39 +0200
Message-ID: <559F7193.7090508@linutronix.de>
References: <20150709213922.GA32698@amd> <20150709214610.GA20890@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150709214610.GA20890@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>, balbi@ti.com, george.cherian@ti.com, tony@atomide.com, varkabhadram@gmail.com, linux-kernel@vger.kernel.org
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

On 07/09/2015 11:46 PM, Pavel Machek wrote:
> On Thu 2015-07-09 23:39:22, Pavel Machek wrote:
>> Hi!

Hi,

>>
>> sysfs should contain one value per file. This one has at least two,
>> with nice english sentence as a bonus.
>>
>> root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
>> cat vbus
>> Vbus off, timeout 1100 msec
>>
>> :-(.
> 
> Plus, documentation for this is nowhere to be seen:
> 
> pavel@amd:/data/l/linux-n900$ grep -ri musb Documentation/ABI/
> pavel@amd:/data/l/linux-n900$

that is a shame indeed. It is part of the driver since TUSB support was
merged via commit 550a7375f ("USB: Add MUSB and TUSB support") about 7
years ago.
The parameter expects the timeout values which is used to poll the port
for mode changes (host/device mode) since it can not be detected on its
own.
Felipe knows best if it is better to document it or remove it. I can't
remember that I needed it on am335x.

> 									Pavel
> 
Sebastian
