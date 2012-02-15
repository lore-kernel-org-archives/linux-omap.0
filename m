From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [RFC 00/11]O MAP/ASoC: Move and merge McBSP driver under ASoC
Date: Wed, 15 Feb 2012 21:06:00 +0200
Message-ID: <4F3C0218.6060802@bitmer.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com> <CAPo=G1z6H+ZXd-cmYSpKXC-XNci7=iUz2he62ze9MyErkmUfOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:44046 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721Ab2BOTFf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 14:05:35 -0500
In-Reply-To: <CAPo=G1z6H+ZXd-cmYSpKXC-XNci7=iUz2he62ze9MyErkmUfOA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, jkrzyszt@tis.icnet.pl, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

On 02/15/2012 05:56 PM, Ujfalusi, Peter wrote:
> Hi,
> 
> CC-ing Janusz, since he is the only one I know who have, and use OMAP1
> with audio...
> Janusz: if your time allows would you be able to test this series on
> OMAP1 (it compiles...)?
> 
Yeah, it would be shame to break omap1, especially considering how much
Janusz has put his personal effort on it.

>> McBSP is only used by audio, there are no known other users of the OMAP McBSP
>> (well, Nokia n700 has the WLAN connected through McBSP but we do not have
>> driver for that anyway).
>>
And since the clock stop mode is not supported in newer omaps there very
unlikely won't be.

>> The series was created against Takashi's topic/asoc branch. I have tested it on
>> Beagle xM, and compile tested it for OMAP1, OMAP2, and OMAP4 as well.
>>
>> I'm going to do more work on the cleanup, and the plan is to merge the two files
>> into one (mcbsp.c -> omap-mcbsp.c) eventually.
>>
>> Comments, testers are welcome...

Unfortunately I won't be able to give any test this week but at quick
look the set looks good to me.

-- 
Jarkko
