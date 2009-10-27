From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [ANNOUNCE] updated dspbridge on linux-omap
Date: Tue, 27 Oct 2009 13:16:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910271309540.10228@utopia.booyaka.com>
References: <20091013201408.GC12700@atomide.com> <27F9C60D11D683428E133F85D2BB4A53042676A3B5@dlee03.ent.ti.com> <20091020010306.GA12576@atomide.com> <20091020.083446.39167794.Hiroshi.DOYU@nokia.com>
 <27F9C60D11D683428E133F85D2BB4A53042681C230@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48338 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbZJ0TQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 15:16:16 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53042681C230@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Linux OMAP <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Shah, Bhavin" <bshah@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Pasam, Vijay" <vpasam@ti.com>, "Premi, Sanjeev" <premi@ti.com>, rnayak@ti.com, "Pandita, Vikram" <vikram.pandita@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>

On Tue, 20 Oct 2009, Ramirez Luna, Omar wrote:

> Also, DVFS Bridge feature won't compile if rebasing onto PM branch 
> because it is missing clk notifier functions.

This should not break compilation.  The DSPBridge code must use 
platform_data function pointers to call clock notifier functions.  

Also, on a related note, I see that EXPORT_SYMBOL() entries have been 
added for many OPP-related functions in plat-omap/omap-pm-*.c.  This is 
not the right way to do it.  These also should be called via platform_data 
function pointers.

Then your code will compile no matter whether the OMAP clock notifier or 
OMAP PM patches are present or not.  The point here is to keep the device 
drivers completely separate from architecture-level code, so you could, 
for example, use DSPBridge on a DaVinci platform.

I will post a patch to remove the EXPORT_SYMBOL() entries from the OMAP PM 
code.


- Paul
