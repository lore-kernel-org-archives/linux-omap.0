From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Fri, 24 Sep 2010 08:01:54 -0700
Message-ID: <87y6arjicd.fsf@deeprootsystems.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
	<20100923063604.GE2563@legolas.emea.dhcp.ti.com>
	<87wrqc4gwd.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
	<87fwx02wl5.fsf@deeprootsystems.com>
	<20100924110129.GV8365@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62070 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab0IXPB5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 11:01:57 -0400
In-Reply-To: <20100924110129.GV8365@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Fri, 24 Sep 2010 14:01:30 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Kalliguddi, Hema" <hemahk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Thu, Sep 23, 2010 at 12:33:58PM -0500, Kevin Hilman wrote:
>>I guess that's Felipe's call, but I don't like that option.
>>
>>I think it's cleaner to have the ->set_clock hook be a noop on OMAP and
>>the runtime hooks be noops on the other platforms.
>
> Agreed. We should focus on removing ->set_clock for .38 actually. Is
> DaVinci already using clkdev, Kevin ?

Yes, it was one of the first to convert.

Kevin
