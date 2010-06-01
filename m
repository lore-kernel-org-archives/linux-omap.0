From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Tue, 01 Jun 2010 10:48:55 -0700
Message-ID: <87bpbubq48.fsf@deeprootsystems.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
	<20100601044734.GB13883@nokia.com> <20100601044919.GD13883@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58732 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681Ab0FARtD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 13:49:03 -0400
In-Reply-To: <20100601044919.GD13883@nokia.com> (Felipe Balbi's message of "Tue\, 1 Jun 2010 07\:49\:19 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "ext Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Felipe Balbi <felipe.balbi@nokia.com> writes:

> On Tue, Jun 01, 2010 at 06:47:34AM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
>>>+	pdata->device_enable = omap_device_enable;
>>
>>this is undefined at least here or previous patch.
>
> or does it come from omap_device layers ??

It's part of the omap_device layer. 

But, drivers no longer should be calling these hooks using
platform_data.  Instead, drivers should use the runtime PM API.  The
runtime PM core for OMAP will use the omap_device API.

Kevin
