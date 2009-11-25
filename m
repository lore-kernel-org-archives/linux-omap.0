From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 0/3] OMAP UART: Adding support for omap-serial driver.
Date: Wed, 25 Nov 2009 10:05:12 -0800
Message-ID: <87pr76fpk7.fsf@deeprootsystems.com>
References: <35552.192.168.10.88.1256713953.squirrel@dbdmail.itg.ti.com>
	<44977.192.168.10.88.1258095220.squirrel@dbdmail.itg.ti.com>
	<d6a0f7aa0911200151xb948a28kf4f22d79e61b993e@mail.gmail.com>
	<20091123170544.GA10313@lixom.net>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402543D7A46@dbde02.ent.ti.com>
	<20091124172139.GA22967@lixom.net>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BBDC7CAD@dbde02.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402543D7ED2@dbde02.ent.ti.com>
	<4B0CD762.70707@lixom.net> <20091125174044.GD4348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:55554 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179AbZKYSFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 13:05:08 -0500
Received: by pxi10 with SMTP id 10so5937872pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 10:05:14 -0800 (PST)
In-Reply-To: <20091125174044.GD4348@atomide.com> (Tony Lindgren's message of "Wed\, 25 Nov 2009 09\:40\:45 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Govindraj <govindraj.ti@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Olof Johansson <olof@lixom.net> [091124 23:05]:
>> G, Manjunath Kondaiah wrote:
>> >>>You should allow both of them to be enabled at the same time, so the
>> >>>same
>> >>>kernel can for example be booted on a ZOOM2 with debug board
>> >>>attached
>> >>>(8250 on GPMC), or on a beagle/overo board.
>> >>>
>> >>>Making them exclusive would be a step backwards.
>> >>More so, selecting both config option really shouldn't break the
>> >>build. If one expect a build break because only one of the
>> >>options can be enabled then clearly the dependency should be
>> >>used so that user can select only one option at a time.
>> >
>> >Ack. There should be dependency in Kconfig so that user can select
>> >either 8250 console(through Quad-uart for zoom2/zoom3) or OMAP-serial
>> >Console(through OMAP UART's).
>> 
>> No. The drivers MUST handle co-existing. You can have a bunch of
>> drivers configured to be _potential_ consoles, which one will end up
>> being used depends on, among other things, the bootargs. But it
>> should be allowed to configure both 8250 and omap-serial at the same
>> time.
>
> Exactly. Even the same board must be capable of using 8250 and
> omap-serial. That's why it must be called ttyO instead of ttyS.

I completely agree with the need for these drivers to co-exist and for
a given board to use both drivers.  For example, Zoom2 would want to
use omap-serial for the on-chip UARTs, and 8250 for the external UART
used for the console.

In my review I complained about using ttyO instead of ttyS, but now I
see more clearly the reason for that.

Kevin


