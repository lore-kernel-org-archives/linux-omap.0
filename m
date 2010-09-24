From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Fri, 24 Sep 2010 14:00:21 +0300
Message-ID: <20100924110021.GU8365@legolas.emea.dhcp.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <87wrqc4gwd.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DF0F@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49035 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab0IXLAw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 07:00:52 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863DF0F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Fri, Sep 24, 2010 at 12:34:09AM -0500, Kalliguddi, Hema wrote:
>Here is the patch which is making use of already existing platform
>set_clock functions pointer.  With this we don't need to use #ifdefs.
>If it looks good I will post it again along with series.

those weren't even used anymore on omap, it's kinda of a step backwards
to get back to using those pointers. I can already see Russell's angry
face when he sees this patch. We should not need such artifacts.

Granted, musb is extremely complicated to make any change because
it's used by several different platforms, so we need to somehow abstract
the platform-specific part and one way is to split the HW glue layer to
another platform_device/driver of its own.

I'm still thinking what's the best way to do that, but there's an RFC on
linux-usb regarding that. Help is welcome :-D

-- 
balbi
