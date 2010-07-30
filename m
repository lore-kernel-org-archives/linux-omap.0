From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v2] twl4030 reboot workaround
Date: Fri, 30 Jul 2010 12:05:46 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323D40C6F@dbde02.ent.ti.com>
References: <20100729061608.GG12063@edollo>
	<1280385678-4366-1-git-send-email-ext-mikko.rapeli@nokia.com>
 <AANLkTi=OkfRGvW05ZTOaSU+-r7jo40wHFK_pkQM9Hmw=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52361 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500Ab0G3Gf5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jul 2010 02:35:57 -0400
In-Reply-To: <AANLkTi=OkfRGvW05ZTOaSU+-r7jo40wHFK_pkQM9Hmw=@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike.rapoport@gmail.com>, Mikko Rapeli <ext-mikko.rapeli@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Turquette, Mike" <mturquette@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Mike
>>Rapoport
>>Sent: Friday, July 30, 2010 12:41 AM
>>To: Mikko Rapeli
>>Cc: linux-omap@vger.kernel.org; Turquette, Mike; sameo@linux.intel.com
>>Subject: Re: [PATCH v2] twl4030 reboot workaround
>>
>>Hi
>>
>>On Thu, Jul 29, 2010 at 9:41 AM, Mikko Rapeli
>><ext-mikko.rapeli@nokia.com> wrote:
>>> From: Mikko Rapeli <ext-mikko.rapeli@nokia.com>
>>>
>>> Original patch: http://marc.info/?l=linux-omap&m=126522625032441&w=2
>>>
>>> "Removes TWL4030 sleep script prior to rebooting, only on OMAP3. This is
>>> necessary since DPLL3 reset causes SYS_OFFMODE pin to go low, resulting
>>> in the sleep script being executed on TWL4030. This usually results in
>>> VDD1 & VDD2 voltage collapse while ROM code is executing, followed by an
>>> MPU Watch Dog reset or worse, an irrecoverable hang."
>>
>>I had a similar issue when my system hanged on hard reset when there
>>was a TWL sleep script installed.
>>The workaround I've found was to install the sleep script immediately
>>before entering the suspend state and remove the script on the resume
>>path.
>>If you think that such approach is appropriate I can send a patch.

How do you hit the off state(Vdd's at 0 V) in the idle path then? Or do you do this every
time in the idle thread also?

Regards
Thara
