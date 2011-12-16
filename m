From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v3] ARM: OMAP2+: hwmod: Add a new state to handle hwmods
 left enabled at init
Date: Fri, 16 Dec 2011 16:33:08 +0530
Message-ID: <4EEB256C.6030306@ti.com>
References: <1321877570-4333-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1112160334100.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:46079 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751233Ab1LPLDQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 06:03:16 -0500
Received: by yhoo47 with SMTP id o47so2691457yho.6
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 03:03:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112160334100.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, robherring2@gmail.com

Hi Paul,

On Friday 16 December 2011 04:07 PM, Paul Walmsley wrote:
> On Mon, 21 Nov 2011, Rajendra Nayak wrote:
>
>> >  An hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
>> >  enabled state by the hwmod framework post the initial setup.
>> >  Once a real user of the device (a driver) tries to enable it
>> >  at a later point, the hwmod framework throws a WARN() about
>> >  the device being already in enabled state.
>> >
>> >  Fix this by introducing a new state '_HWMOD_STATE_ENABLED_AT_INIT'
>> >  to identify such devices/hwmods. When the device/hwmod
>> >  is requested to be enabled (the first time) by its driver/user,
>> >  nothing except the mux-enable and a state change to '_HWMOD_STATE_ENABLED'
>> >  is needed. The mux data is board specific and is unavailable during
>> >  initial enable() of the device, done by the framework as part of
>> >  setup().
>> >
>> >  A good example of a such a device is an UART used as debug console.
>> >  The UART module needs to be kept enabled through the boot, until the
>> >  UART driver takes control of it, for debug prints to appear on
>> >  the console.
>> >
>> >  Acked-by: Kevin Hilman<khilman@ti.com>
>> >  Acked-by: Benoit Cousson<b-cousson@ti.com>
>> >  Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> I've tweaked this patch a little bit, mostly to avoid adding a new state,
> which increases the complexity of the rest of the code that handles the
> hwmod state machine.  The modified patch below just uses an internal flag.
> Please let me know if you have any comments.

Looks good to me.

thanks,
Rajendra

