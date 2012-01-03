From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: It looks like snd-soc-rx51 only works as built-in, not as a module
Date: Tue, 03 Jan 2012 00:19:17 +0000
Message-ID: <yw1xobul8woq.fsf@unicorn.mansr.com>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
	<20111210082741.GA32605@earth.universe>
	<CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
	<20111229183712.GB32392@sirena.org.uk>
	<CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com>
	<20111229212707.GA9737@opensource.wolfsonmicro.com>
	<CAMP44s2SU_M0Fpt43YDLLhPrgsGzkgpHRWHLcJO4f8N=0HHdvg@mail.gmail.com>
	<20111229215407.GB9737@opensource.wolfsonmicro.com>
	<CAMP44s0EzmhdZ4X91c5X7Rn9q44QcUDm2KNDO81ue16SBWM6_g@mail.gmail.com>
	<20111231005935.GA5835@opensource.wolfsonmicro.com>
	<CAMP44s1hUYAcMTDBBPAbV=m39oGrbKXUhv44bp71XkNg-dEBzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:36573 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab2ACATT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jan 2012 19:19:19 -0500
In-Reply-To: <CAMP44s1hUYAcMTDBBPAbV=m39oGrbKXUhv44bp71XkNg-dEBzA@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 2 Jan 2012 20:33:03 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sebastian Reichel <sre@debian.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Sat, Dec 31, 2011 at 2:59 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Fri, Dec 30, 2011 at 10:00:55PM +0200, Felipe Contreras wrote:
>>> On Thu, Dec 29, 2011 at 11:54 PM, Mark Brown
>>> > On Thu, Dec 29, 2011 at 11:51:11PM +0200, Felipe Contreras wrote:
>>
>>> >> >> > That should not be required, the modules should be loadable=
 in any
>>> >> >> > order.
>>
>>> >> Yes, but udev loads snd_soc_tlv320aic3x, not snd-soc-rx51.
>>
>>> > That is compltelely orthogonal to what you were saying above abou=
t the
>>> > ordering of module loading.
>>
>>> Not really, because if both are compiled as modules,
>>> snd_soc_tlv320aic3x will always be loaded first (automatically by
>>> udev).
>>
>> Which is relevant because...? =A0To repeat, the ordering of module l=
oading
>> is totally ortogonal as any ordering of modules is supported. =A0You
>> appear to be totally ignoring what I am writing here.
>
> One thing how things _should_ be, and another is how things actually
> _are_. Right now snd-soc-rx51 doesn't work if it's loaded before
> snd_soc_tlv320aic3x. Period.
>
> That means that *right now*, snd-soc-rx51 works fine with udev,
> because snd_soc_tlv320aic3x will be loaded at boot time. Now, if
> snd-soc-rx51 is converted and loaded automatically by udev as well,
> the issues might appear again.
>
>>> > The reason the driver is not loaded automatically is that the OMA=
P
>>> > machine drivers have not been converted to platform devices.
>>
>>> Well, if that's the case then there's a real issue. There doesn't s=
eem
>>> to be a MODULE_DEPENDS(), or anything like that.
>>
>> A MODULE_DEPENDS() would also be irrelevant here.
>
> Ok.
>
>>> snd-soc-rx51 seems to depend on snd_soc_tlv320aic3x through
>>> codec_dai_name, and codec_name, and so on. I don't know how this
>>> dependency is supposed to work out.
>>
>> All the drivers should load via the normal driver instantiation
>> mechainsms and when they're all there they'll get matched together.
>
> Ok, I hope so.

Does this patch change anything?
http://article.gmane.org/gmane.linux.alsa.devel/89052

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
