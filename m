From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
Date: Thu, 24 Jan 2013 16:45:14 +0100
Message-ID: <5101570A.1030303@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch> <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch> <5101510C.9050407@ti.com> <51015663.8080109@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37448 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab3AXPpZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 10:45:25 -0500
In-Reply-To: <51015663.8080109@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/24/2013 04:42 PM, Florian Vaussard wrote:
> I did it at first, but the led API executes in atomic context, where =
the
> pwm-twl-led driver uses i2c communication. Setting a trigger will res=
ult in a
> kernel panic.

Now that you mentioned it, this might be true.

> I am working on a patch for pwm-twl-led to defer using a workqueue ri=
ght now.

Great!
The only thing I worry about is the latency we are going to get with th=
e
workqueue.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
