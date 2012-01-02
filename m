From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: It looks like snd-soc-rx51 only works as built-in, not as a module
Date: Mon, 2 Jan 2012 20:33:03 +0200
Message-ID: <CAMP44s1hUYAcMTDBBPAbV=m39oGrbKXUhv44bp71XkNg-dEBzA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62662 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab2ABSdF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jan 2012 13:33:05 -0500
Received: by eaad14 with SMTP id d14so8144391eaa.19
        for <linux-omap@vger.kernel.org>; Mon, 02 Jan 2012 10:33:03 -0800 (PST)
In-Reply-To: <20111231005935.GA5835@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sebastian Reichel <sre@debian.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On Sat, Dec 31, 2011 at 2:59 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Dec 30, 2011 at 10:00:55PM +0200, Felipe Contreras wrote:
>> On Thu, Dec 29, 2011 at 11:54 PM, Mark Brown
>> > On Thu, Dec 29, 2011 at 11:51:11PM +0200, Felipe Contreras wrote:
>
>> >> >> > That should not be required, the modules should be loadable =
in any
>> >> >> > order.
>
>> >> Yes, but udev loads snd_soc_tlv320aic3x, not snd-soc-rx51.
>
>> > That is compltelely orthogonal to what you were saying above about=
 the
>> > ordering of module loading.
>
>> Not really, because if both are compiled as modules,
>> snd_soc_tlv320aic3x will always be loaded first (automatically by
>> udev).
>
> Which is relevant because...? =C2=A0To repeat, the ordering of module=
 loading
> is totally ortogonal as any ordering of modules is supported. =C2=A0Y=
ou
> appear to be totally ignoring what I am writing here.

One thing how things _should_ be, and another is how things actually
_are_. Right now snd-soc-rx51 doesn't work if it's loaded before
snd_soc_tlv320aic3x. Period.

That means that *right now*, snd-soc-rx51 works fine with udev,
because snd_soc_tlv320aic3x will be loaded at boot time. Now, if
snd-soc-rx51 is converted and loaded automatically by udev as well,
the issues might appear again.

>> > The reason the driver is not loaded automatically is that the OMAP
>> > machine drivers have not been converted to platform devices.
>
>> Well, if that's the case then there's a real issue. There doesn't se=
em
>> to be a MODULE_DEPENDS(), or anything like that.
>
> A MODULE_DEPENDS() would also be irrelevant here.

Ok.

>> snd-soc-rx51 seems to depend on snd_soc_tlv320aic3x through
>> codec_dai_name, and codec_name, and so on. I don't know how this
>> dependency is supposed to work out.
>
> All the drivers should load via the normal driver instantiation
> mechainsms and when they're all there they'll get matched together.

Ok, I hope so.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
