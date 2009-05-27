From: Blazej Kot <bjk45@cornell.edu>
Subject: Re: Gumstix Overo Low Power Standby?
Date: Wed, 27 May 2009 15:05:42 -0400
Message-ID: <438563CD-9AA9-41A4-A015-D9BAA40550D3@cornell.edu>
References: <E7CF933B-CAC8-4F9E-AA3F-C64F36063C8F@cornell.edu> <87ws8bog2c.fsf@deeprootsystems.com> <87iqjvoe0q.fsf@deeprootsystems.com> <249CF2F5-CA30-49BE-8524-B81AEC4D42A5@cornell.edu> <4A1D8D8E.9070501@googlemail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from granite1.mail.cornell.edu ([128.253.83.141]:58021 "EHLO
	authusersmtp.mail.cornell.edu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1761299AbZE0TFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2009 15:05:46 -0400
In-Reply-To: <4A1D8D8E.9070501@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>


On May 27, 2009, at 2:59 PM, Dirk Behme wrote:

> Blazej Kot wrote:
>>
>> Thanks for that, it is an interesting link. I have now reached the  
>> new low of around 170mW (at 3.28V), but this is high. I basically  
>> used the TWL (PMC) scripts in the linked post, and also turned off  
>> the U6 chip on the gumstix, which is the USB PHY layer driver.
>> Also,  I noticed that my systems becomes unusable after suspending  
>> for more than abut a minute, and it will not wake from sleep. I  
>> will try to troubleshot and narrow this down.
>
> I think to remember there was some discussion about SDRAM self  
> refresh. Look for thread "OMAP3: PM: SDRC: ensure mux of SDRC clock  
> enable pins for self-refresh" and
>
> http://www.sakoman.net/cgi-bin/gitweb.cgi?p=u-boot-omap3.git;a=commit;h=4025cfbde3611b14c0d4831a5524e5e061128e30
>
> Just guessing, though.
>
> Dirk

Yes, you are quite right. Kevin Hilman pointed out the patch [1] to  
me, I just applied it and suspend/resume works for at least 5-10  
minutes. I'll try it overnight next :)

One small thing is I had to manually insert and  include for mach/ 
mux.c to the top of sdrc.c for it to compile.

Thanks!
Blazej

PS: I'm now down to 141mW in suspend :) I know a lot of the rest must  
be getting used up in the TPS/TWL PM chip, as it is slightly warm to  
the touch while the OMAP/RAM stack and the only other chip on the  
overo, the USB PHY chip, are stone cold to the touch.

[1] http://marc.info/?l=linux-omap&m=124283570910883&w=2
>

