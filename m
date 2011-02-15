From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 5/5 v6] usb: musb: Using runtime pm APIs for musb.
Date: Mon, 14 Feb 2011 16:42:02 -0800
Message-ID: <87oc6ew2lh.fsf@ti.com>
References: <1297346881-13438-1-git-send-email-hemahk@ti.com>
	<1297346881-13438-6-git-send-email-hemahk@ti.com>
	<20110210142605.GR3580@legolas.emea.dhcp.ti.com>
	<98ff144ea4e715250c54712ebbfb494f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39643 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752396Ab1BOAmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 19:42:11 -0500
In-Reply-To: <98ff144ea4e715250c54712ebbfb494f@mail.gmail.com> (Hema
	Kalliguddi's message of "Thu, 10 Feb 2011 22:09:45 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema Kalliguddi <hemahk@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hema Kalliguddi <hemahk@ti.com> writes:

[...]

>>On Thu, Feb 10, 2011 at 07:38:01PM +0530, Hema HK wrote:
>>> Calling runtime pm APIs pm_runtime_put_sync() and
>>pm_runtime_get_sync()
>>> for enabling/disabling the clocks, sysconfig settings.
>>>
>>> Enable clock, configure no-idle/standby when active and
>>configure force idle/standby
>>> and disable clock when idled. This is taken care by the
>>runtime framework when
>>> driver calls the pm_runtime_get_sync and pm_runtime_put_sync APIs.
>>
>>does it have to be the _sync() ??
> Yes. Because immediately after this I access the registers.
>

What about the put?

Kevin
 
