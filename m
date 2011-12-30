From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [alsa-devel] It looks like snd-soc-rx51 only works as built-in,
 not as a module
Date: Fri, 30 Dec 2011 13:15:06 +0200
Message-ID: <4EFD9D3A.7090208@bitmer.com>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>	<20111210082741.GA32605@earth.universe>	<CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>	<20111229183712.GB32392@sirena.org.uk>	<CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com>	<20111229212707.GA9737@opensource.wolfsonmicro.com>	<CAMP44s2SU_M0Fpt43YDLLhPrgsGzkgpHRWHLcJO4f8N=0HHdvg@mail.gmail.com>	<20111229215407.GB9737@opensource.wolfsonmicro.com>	<yw1x7h1ff26w.fsf@unicorn.mansr.com> <20111230105244.GA21638@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33537 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606Ab1L3LPj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Dec 2011 06:15:39 -0500
In-Reply-To: <20111230105244.GA21638@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 12/30/2011 12:52 PM, Mark Brown wrote:
> On Thu, Dec 29, 2011 at 10:22:31PM +0000, M?ns Rullg?rd wrote:
>> Mark Brown<broonie@opensource.wolfsonmicro.com>  writes:
>
>>> The reason the driver is not loaded automatically is that the OMAP
>>> machine drivers have not been converted to platform devices.
>
>> I posted patches doing the conversion a long time ago (September?). =
 It
>> seems they got lost somewhere.
>
> Most of them have been converted, but the rx51 wasn't.

I guess that patch has been forgotten. M=E5ns: care to check and resend=
?=20
It's definitely great to get OMAP ASoC machine driver autoloading worki=
ng.

--=20
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
