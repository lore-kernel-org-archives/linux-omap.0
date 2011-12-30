From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [alsa-devel] It looks like snd-soc-rx51 only works as built-in, not as a module
Date: Fri, 30 Dec 2011 19:34:29 +0000
Message-ID: <yw1xaa69dfay.fsf@unicorn.mansr.com>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
	<20111210082741.GA32605@earth.universe>
	<CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
	<20111229183712.GB32392@sirena.org.uk>
	<CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com>
	<20111229212707.GA9737@opensource.wolfsonmicro.com>
	<CAMP44s2SU_M0Fpt43YDLLhPrgsGzkgpHRWHLcJO4f8N=0HHdvg@mail.gmail.com>
	<20111229215407.GB9737@opensource.wolfsonmicro.com>
	<yw1x7h1ff26w.fsf@unicorn.mansr.com>
	<20111230105244.GA21638@sirena.org.uk>
	<yw1xy5ttex9k.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:49271 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab1L3Teb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Dec 2011 14:34:31 -0500
In-Reply-To: <yw1xy5ttex9k.fsf@unicorn.mansr.com> (=?iso-8859-1?Q?=22M=E5n?=
 =?iso-8859-1?Q?s_Rullg=E5rd=22's?= message
	of "Fri, 30 Dec 2011 18:21:11 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

M=E5ns Rullg=E5rd <mans@mansr.com> writes:

> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>
>> On Thu, Dec 29, 2011 at 10:22:31PM +0000, M?ns Rullg?rd wrote:
>>> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>>
>>> > The reason the driver is not loaded automatically is that the OMA=
P
>>> > machine drivers have not been converted to platform devices.
>>
>>> I posted patches doing the conversion a long time ago (September?).=
  It
>>> seems they got lost somewhere.
>>
>> Most of them have been converted,
>
> In which tree?  I haven't seen anything of the kind.
>
>> but the rx51 wasn't.
>
> RX51 was done in my patch...

That would be this one:
http://article.gmane.org/gmane.linux.alsa.devel/89052

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
