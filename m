From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] ASoC: tlv320aic3x: add initial usage of regulator framework to control avdd_dac
Date: Thu, 8 Oct 2009 17:01:04 +0100
Message-ID: <1C729A43-F9F2-4FF6-A07E-5450E595982B@opensource.wolfsonmicro.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com> <1255003137-1034-8-git-send-email-eduardo.valentin@nokia.com> <1255004227.30157.159.camel@eenurkka-desktop>,<20091008134046.GH29176@rakim.wolfsonmicro.main> <1FFEF31EBAA4F64B80D33027D42977600E85F0CC91@NOK-EUMSG-02.mgdnok.nokia.com> (sfid-20091008_164425_486507_1ADB55B0)
Mime-Version: 1.0 (iPhone Mail 7C144)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53310 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753955AbZJHQBr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 12:01:47 -0400
In-Reply-To: <1FFEF31EBAA4F64B80D33027D42977600E85F0CC91@NOK-EUMSG-02.mgdnok.nokia.com> (sfid-20091008_164425_486507_1ADB55B0)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "<ext-Eero.Nurkkala@nokia.com>" <ext-Eero.Nurkkala@nokia.com>
Cc: "<eduardo.valentin@nokia.com>" <eduardo.valentin@nokia.com>, "<tony@atomide.com>" <tony@atomide.com>, "<peter.ujfalusi@nokia.com>" <peter.ujfalusi@nokia.com>, "<jhnikula@gmail.com>" <jhnikula@gmail.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<alsa-devel@vger.kernel.org>" <alsa-devel@vger.kernel.org>

On 8 Oct 2009, at 16:44, <ext-Eero.Nurkkala@nokia.com> wrote:

> Mark Brown wrote:
>>
>>>                                         Also, this is regulator  
>>> thing
>>> is highly platform dependent, not aic3x related really at all, so is
>>> this the correct place... Just a thought, dont take it too  
>>> seriously ;)
>>
>> I'm not sure what you mean by this?
>
> You may power the aic3x from a fixed source, or from multiple  
> sources, with
> and without any regulator in between. It's up to the HW and HW design.

The regulator API can cope with all this pretty transparently - if  
multiple supplies come from the same regulator the API will hide that  
from the consumer. There is a fixed voltage regulator driver which can  
be used to represent supplies with no soft control.

> Moreover, you don't _power off_ (turn the regulator off) the analog  
> voltages
> of aic3x; things won't work. So it's not like a switch everybody may  
> use. Or
> nothing prevent you from experiencing that...

I'd expect the usage would be that after the audio subsystem has been  
idle for some configurable period of time the core would bring the  
audio subsystem down to bias off, at which point supplies could also  
be switched off.
