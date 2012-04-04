From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Suspend broken on 3.3?
Date: Wed, 4 Apr 2012 08:56:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204040852460.8000@utopia.booyaka.com>
References: <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk> <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com> <WC20120330075339.4017FC@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
 <WC20120330092609.901834@terrafix.co.uk> <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com> <WC20120330110442.381887@terrafix.co.uk> <CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com>
 <CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37401 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756354Ab2DDO4U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 10:56:20 -0400
In-Reply-To: <CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

Hello Govindraj

On Mon, 2 Apr 2012, Raja, Govindraj wrote:

> As of now what I can think of is to update qos reqest to prevent MPU
> from transitioning in case of port activity if wakeup capability for port
> is disabled.

Haven't been following this thread closely, but this doesn't seem right.  
Why would changing the UART driver's ability to wake from suspend via the 
sysfs file prevent the driver from using hardware wakeups to wake from 
dynamic idle?


- Paul
