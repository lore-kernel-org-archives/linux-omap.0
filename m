From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: status of USB on omap35xx ?
Date: Sat, 13 Dec 2008 02:31:12 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087025106711C@dbde02.ent.ti.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
  <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
  <20081211005733.GZ18138@atomide.com>
  <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
  <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>
  <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com>
  <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com>
  <alpine.DEB.2.00.0812111401100.26754@utopia.booyaka.com>
  <6ed0b2680812111452t75b175bdr304e9b1d22ea93de@mail.gmail.com>
  <alpine.DEB.2.00.0812111603520.26754@utopia.booyaka.com>
 <6ed0b2680812121215m15ff0e59t8ede0e5dca5b6270@mail.gmail.com>
 <alpine.DEB.2.00.0812121331180.26754@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbYLLVBd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2008 16:01:33 -0500
In-Reply-To: <alpine.DEB.2.00.0812121331180.26754@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

Paul

>-----Original Message-----
>From: Paul Walmsley [mailto:paul@pwsan.com]
>Sent: Friday, December 12, 2008 2:33 PM
>To: Pandita, Vikram
>Cc: Grazvydas Ignotas; Steve Sakoman; Tony Lindgren; David Brownell; me@felipebalbi.com; Jeff Steele;
>linux-omap
>Subject: Re: status of USB on omap35xx ?
>
>Hello Vikram,
>
>On Fri, 12 Dec 2008, Grazvydas Ignotas wrote:
>
>> On Fri, Dec 12, 2008 at 1:09 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> > On Fri, 12 Dec 2008, Grazvydas Ignotas wrote:
>>
>> >> I'm also getting suspend/resume related problems if I plug a hub
>> >> without any devices connected (29sec), and then a device (52sec):
>> >
>> > If you disable USB autosuspend with no devices connected via
>> >
>> > echo -1 > /sys/module/usbcore/parameters/autosuspend
>> >
>> > and then repeat the same test as above, do your devices stay alive?
>> Yep, this seems to resolve that issue, I can plug the devices any way
>> I want with this. Thanks for showing this.
>
>Were you able to get USB remote wakeup or auto-suspend working on
>ehci-omap.c with the 3430SDP?

For remote-wakeup: 
There was a long discussion with USBHOST IP vendor. We were observing a device disconnect on a remote-wakeup as well as host initiated wakeup.

It turned out to be an issue with the IP block and will be fixed in 3430 ES3.1 finally.
And a software workaround for waiting for USB micro frame boundary. 
Now the workaround has been done in USB EHCI stack code which is not the best way ... 

Take a look at Zoom GIT tree for the reference implementation: 
http://git.omapzoom.com/?p=omapkernel.git;a=commitdiff;h=baa196583f4af08d15da0389fed8f9005b0f812d


