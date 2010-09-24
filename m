From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Fri, 24 Sep 2010 11:43:44 +0300
Message-ID: <20100924084344.GJ8365@legolas.emea.dhcp.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <87wrqc4gwd.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
 <87fwx02wl5.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E087@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34627 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab0IXIoM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 04:44:12 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863E087@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Fri, Sep 24, 2010 at 03:16:29AM -0500, Kalliguddi, Hema wrote:
>>I guess that's Felipe's call, but I don't like that option.
>>
>>I think it's cleaner to have the ->set_clock hook be a noop on OMAP
>>and the runtime hooks be noops on the other platforms.
>>
>I think the set_clock function was used for setting the platform
>specific clocks for different architecture. Anyway we need this hook or
>some other hook once we start handling the optional clocks and internal
>phy clocks for musb.  Since this is already exists I thought of making
>use of it instand of adding another hook.
>
>Felipe, What do you say?

Ideally we will get rid of those. It's only a matter of getting DaVinci
to fully support clkdev. We should not have wrappers on top of clk
framework neither pass down clock names as platform_data to driver,
that's insane.

-- 
balbi
