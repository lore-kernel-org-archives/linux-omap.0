From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH/RFC] ARM: OMAP: MUSB: disable omap_device auto-suspend
Date: Mon, 30 Jan 2012 00:57:13 +0200
Message-ID: <CANOLnOM-V4SFSL7+-ji00fJBu8TC06-pSNWZXA36pqW=4YGFQQ@mail.gmail.com>
References: <1322528190-9274-1-git-send-email-khilman@ti.com>
	<20111207064954.GD32368@legolas.emea.dhcp.ti.com>
	<87k468w4v4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38042 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753954Ab2A2W5P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 29 Jan 2012 17:57:15 -0500
Received: by lagu2 with SMTP id u2so1891954lag.19
        for <linux-omap@vger.kernel.org>; Sun, 29 Jan 2012 14:57:13 -0800 (PST)
In-Reply-To: <87k468w4v4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>

Hello,

I've been trying to get suspend working with musb compiled in on 3.2.
It seems both patches from this thread are needed, Kevin's patch stops
omap2430_runtime_suspend() from being called at inappropriate time
(when i2c is suspended [1]) and Felipe's patch brings that call back
at better time (when i2c is still active). Perhaps they can be applied
now, as current state crashes for me (see [1])?

However there is a new issue with these patches applied, core_pwrdm no
longer enters low power state, but I think I've found why. After
omap_device_disable_idle_on_suspend() call, _od_suspend_noirq()
function in omap_device.c no longer calls omap_device_idle(), which
means things (clocks?) are not properly stopped before entering
suspend, preventing core_pwrdm from going down.

So I guess the question is, can it be done that
omap2430_runtime_suspend() could access i2c and omap_device_idle()
would be called?

[1] For some reason I get data abort on i2c register access if it's
suspended, not i2c timeouts that some people report..


On Wed, Dec 7, 2011 at 9:37 PM, Kevin Hilman <khilman@ti.com> wrote:
> Felipe Balbi <balbi@ti.com> writes:
>
>> Hi,
>>
>> On Mon, Nov 28, 2011 at 04:56:30PM -0800, Kevin Hilman wrote:
>>> The MUSB driver does not currently implment suspend/resume callback=
s,
>>
>> this is not entirelly true, actually. Such methods are missing for
>> omap2430 glue layer, not for MUSB itself. And the fact is that it's =
only
>> missing because we failed to use UNIVERSAL_DEV_PM_OPS for declaring
>> dev_pm_ops structure.
>
> I guess that also means that nobody has tested MUSB host suspend/resu=
me
> with devices attached.
>
>> Can you see if this patch helps:
>
> Sure.
>
> That patch makes sense, and seems necessary, but doesn't fix the prob=
lem.
>
> The root of the problem is that the PM domain code will call the
> driver's runtime PM methods late in the suspend if the device is not
> already runtime suspended.
>
> In your patch, you make the driver's suspend/resume methods call the
> runtime methods, but, the PM core doesn't know that that the device i=
s now
> runtime suspended, so the OMAP PM domain code will still call the
> driver's runtime PM methods to try and suspend the device.
>
> In the case of this glue layer, the runtime PM methods call some PHY
> code which is trying to use I2C. =C2=A0When this happens late in the =
suspend
> process, I2C may already be suspended, so you get a bunch of I2C
> timeouts.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
