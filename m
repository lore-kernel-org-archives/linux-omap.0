From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Mon, 27 Sep 2010 09:07:38 +0300
Message-ID: <20100927060738.GB8365@legolas.emea.dhcp.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <87wrqc4gwd.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
 <87fwx02wl5.fsf@deeprootsystems.com>
 <20100924110129.GV8365@legolas.emea.dhcp.ti.com>
 <4C9CBA7E.9090107@ru.mvista.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47580 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012Ab0I0GJH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Sep 2010 02:09:07 -0400
Content-Disposition: inline
In-Reply-To: <4C9CBA7E.9090107@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Kalliguddi, Hema" <hemahk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Fri, Sep 24, 2010 at 09:49:34AM -0500, Sergei Shtylyov wrote:
>Hello.
>
>Felipe Balbi wrote:
>
>>> I guess that's Felipe's call, but I don't like that option.
>
>>> I think it's cleaner to have the ->set_clock hook be a noop on OMAP and
>>> the runtime hooks be noops on the other platforms.
>
>> Agreed. We should focus on removing ->set_clock for .38 actually. Is
>> DaVinci already using clkdev, Kevin ?
>
>    Sure. But DaVinci doesn't use ->set_clock().

Ok, so seems like no-one is actually using that. We can already start
patching to remove that thing, later on, we need to remove the clock
name via platform_data.

-- 
balbi
