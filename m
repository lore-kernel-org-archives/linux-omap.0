From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Tue, 28 Sep 2010 09:00:22 +0300
Message-ID: <20100928060022.GE2702@legolas.emea.dhcp.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <87wrqc4gwd.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
 <87fwx02wl5.fsf@deeprootsystems.com>
 <20100924110129.GV8365@legolas.emea.dhcp.ti.com>
 <4C9CBA7E.9090107@ru.mvista.com>
 <20100927060738.GB8365@legolas.emea.dhcp.ti.com>
 <4CA06854.7050804@mvista.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42610 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab0I1GAe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 02:00:34 -0400
Content-Disposition: inline
In-Reply-To: <4CA06854.7050804@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Kalliguddi, Hema" <hemahk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Mon, Sep 27, 2010 at 04:48:04AM -0500, Sergei Shtylyov wrote:
>Hello.
>
>On 27-09-2010 10:07, Felipe Balbi wrote:
>
>>>>> I guess that's Felipe's call, but I don't like that option.
>
>>>>> I think it's cleaner to have the ->set_clock hook be a noop on OMAP and
>>>>> the runtime hooks be noops on the other platforms.
>
>>>> Agreed. We should focus on removing ->set_clock for .38 actually. Is
>>>> DaVinci already using clkdev, Kevin ?
>
>>> Sure. But DaVinci doesn't use ->set_clock().
>
>> Ok, so seems like no-one is actually using that.
>
>    I thought OMAP does... but I'm seeing now that it doesn't.
>
>> We can already start
>> patching to remove that thing, later on, we need to remove the clock
>> name via platform_data.
>
>    As I've said already, there are cases where two clocks is needed by MUSB
>(like AM3517) or where USB 2.0 clock is also needed by the OHCI driver
>(DA8xx), hence the name seems needed still...

we can all go through all that discussion with Russell again and will
come down to the same conclusion: clock names should never be needed.

-- 
balbi
