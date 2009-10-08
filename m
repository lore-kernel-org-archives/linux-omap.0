From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: [PATCH 7/8] ASoC: tlv320aic3x: add initial usage of regulator
 framework to control avdd_dac
Date: Thu, 8 Oct 2009 17:44:05 +0200
Message-ID: <1FFEF31EBAA4F64B80D33027D42977600E85F0CC91@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
 <1255003137-1034-8-git-send-email-eduardo.valentin@nokia.com>
 <1255004227.30157.159.camel@eenurkka-desktop>,<20091008134046.GH29176@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51015 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758206AbZJHPps convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 11:45:48 -0400
In-Reply-To: <20091008134046.GH29176@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: eduardo.valentin@nokia.com, tony@atomide.com, peter.ujfalusi@nokia.com, jhnikula@gmail.com, linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

Mark Brown wrote:

>> Will this ever be revisited =) ? If so, I think there's going to be a
>> jungle in finding the right spots - you need to remember the bypass
>> paths also (bias is not on necessarily).
>
> The bias is always on when any path through the chip is on, this was
> fixed in either .31 or .30.

Good! Thanks for the update.

>>                                          Also, this is regulator thing
>> is highly platform dependent, not aic3x related really at all, so is
>> this the correct place... Just a thought, dont take it too seriously ;)
> 
> I'm not sure what you mean by this?

You may power the aic3x from a fixed source, or from multiple sources, with
and without any regulator in between. It's up to the HW and HW design.

Moreover, you don't _power off_ (turn the regulator off) the analog voltages
of aic3x; things won't work. So it's not like a switch everybody may use. Or
nothing prevent you from experiencing that...

- EEro

