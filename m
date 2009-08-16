From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [beagleboard] Re: USB EHCI problems
Date: Sat, 15 Aug 2009 18:19:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908151812450.25748@utopia.booyaka.com>
References: <cc69eebf0907230459jb47f4e9pb1b5953a4819aa45@mail.gmail.com> <cc69eebf0908130606l78849436j459f4bf4ceaecf7b@mail.gmail.com> <4A85E7D0.2070807@gmail.com> <200908152304.15249.siarhei.siamashka@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50287 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbZHPATX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 20:19:23 -0400
In-Reply-To: <200908152304.15249.siarhei.siamashka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: beagleboard@googlegroups.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

On Sat, 15 Aug 2009, Siarhei Siamashka wrote:

> But this wiki page has comment:
> "Enables SmartReflex autocompensation on VDD2 (Note: This feature can only be 
> tested on a ES3.1 silicon):
> # echo 1 > /sys/power/sr_vdd2_autocomp"
> 
> And AFAIK beagleboard revision C has ES3.0 silicon. So no luck here. Or can
> something still be done?

It should be possible to enable SmartReflex on <ES3.1, but the SR register 
values need to be programmed at runtime.  (ES3.1 has the SR register 
values blown in to eFUSE OTPROM)

As far as I know, only TI has this information, so it's up to them to 
release it.  Although one of the device vendor kernel patches/tarballs 
might have something useful here - I haven't looked recently.


- Paul
