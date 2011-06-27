From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] mfd: omap: Restore TLL initialization
Date: Mon, 27 Jun 2011 15:04:09 -0700
Message-ID: <87ei2f9bja.fsf@ti.com>
References: <1308862894-13802-1-git-send-email-jaswinder.singh@linaro.org>
	<BANLkTikFFUREhKyPaZrhHZje0KeaA3ef8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54524 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755139Ab1F0WEN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 18:04:13 -0400
In-Reply-To: <BANLkTikFFUREhKyPaZrhHZje0KeaA3ef8Q@mail.gmail.com> (Keshava
	Munegowda's message of "Fri, 24 Jun 2011 11:52:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, ti@lists.linaro.org, parthab@india.ti.com, sameo@linux.intel.com, gadiyar@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>

"Munegowda, Keshava" <keshava_mgowda@ti.com> writes:

> On Fri, Jun 24, 2011 at 2:31 AM, Jassi Brar <jassisinghbrar@gmail.com=
> wrote:
>> The commit
>> =C2=A07e6502d577106fb5b202bbaac64c5f1b065 'mfd: Add omap-usbhs runti=
me PM support'
>> besides moving to RPM, removes necessary TLL initialization as well.
>>
>> Restore the TLL initialization, without which device detection fails=
=2E
>>
>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>

[...]

> if you move to RPM, you should'tn access these configuration/reset
> registers in your driver.

Yes, but Jaswinder's changelog clearly shows that the runtime PM (and
thus hwmod) init is not doing the equivalent of what was removed from
the driver.

A hunch after a quick glance is that the driver changes are only doing
runtime PM calls on the UHH device and not the TTL device.  In fact,
the patch that builds the USB host omap_device[1] doesn't even build on=
e.

> moreover, the patch 'mfd: Add omap-usbhs runtime PM support' is
> already reverted.

It is reverted for this merge window, but will be added back for the
next window, so Jaswinder's problem still needs to be fixed the right w=
ay.

Please rework the USB host runtime PM conversion so that *all* the IP
blocks are managed by runtime PM and the driver is doing runtime PM
calls for all the devices used.

Kevin

[1] http://marc.info/?l=3Dlinux-omap&m=3D130693494126396&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
