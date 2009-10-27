From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [ANNOUNCE] updated dspbridge on linux-omap
Date: Tue, 27 Oct 2009 15:09:52 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426933786@dlee03.ent.ti.com>
References: <20091013201408.GC12700@atomide.com>
 <27F9C60D11D683428E133F85D2BB4A53042676A3B5@dlee03.ent.ti.com>
 <20091020010306.GA12576@atomide.com>
 <20091020.083446.39167794.Hiroshi.DOYU@nokia.com>
 <27F9C60D11D683428E133F85D2BB4A53042681C230@dlee03.ent.ti.com>
 <alpine.DEB.2.00.0910271309540.10228@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34636 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755645AbZJ0UKE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 16:10:04 -0400
In-Reply-To: <alpine.DEB.2.00.0910271309540.10228@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Linux OMAP <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Shah, Bhavin" <bshah@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Pasam, Vijay" <vpasam@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>

Hi Paul,

>From: Paul Walmsley [mailto:paul@pwsan.com]
>Sent: Tuesday, October 27, 2009 2:16 PM
>
>On Tue, 20 Oct 2009, Ramirez Luna, Omar wrote:
>
>> Also, DVFS Bridge feature won't compile if rebasing onto PM branch
>> because it is missing clk notifier functions.
>
>This should not break compilation.  The DSPBridge code must use
>platform_data function pointers to call clock notifier functions.
>

Agree, we do use platform_data to call DVFS related functions:

static struct dspbridge_platform_data dspbridge_pdata __initdata = {
#ifdef CONFIG_BRIDGE_DVFS
	.dsp_set_min_opp = omap_pm_dsp_set_min_opp,
	.dsp_get_opp     = omap_pm_dsp_get_opp,
	.cpu_set_freq    = omap_pm_cpu_set_freq,
	.cpu_get_freq    = omap_pm_cpu_get_freq,
#endif
};

What I meant is that I couldn't find clk_notifier_* functions in pm-branch others than 2.6.28 and 2.6.29, I'll retry looking for them though, I just assumed that they should be under plat-omap/clocks.c

>Also, on a related note, I see that EXPORT_SYMBOL() entries have been
>added for many OPP-related functions in plat-omap/omap-pm-*.c.  This is
>not the right way to do it.  These also should be called via platform_data
>function pointers.
>
>Then your code will compile no matter whether the OMAP clock notifier or
>OMAP PM patches are present or not.  The point here is to keep the device
>drivers completely separate from architecture-level code, so you could,
>for example, use DSPBridge on a DaVinci platform.
>
>I will post a patch to remove the EXPORT_SYMBOL() entries from the OMAP PM
>code.
>
>
>- Paul

- omar
