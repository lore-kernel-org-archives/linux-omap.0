From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: It looks like snd-soc-rx51 only works as built-in, not as a module
Date: Thu, 29 Dec 2011 22:22:31 +0000
Message-ID: <yw1x7h1ff26w.fsf@unicorn.mansr.com>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
	<20111210082741.GA32605@earth.universe>
	<CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
	<20111229183712.GB32392@sirena.org.uk>
	<CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com>
	<20111229212707.GA9737@opensource.wolfsonmicro.com>
	<CAMP44s2SU_M0Fpt43YDLLhPrgsGzkgpHRWHLcJO4f8N=0HHdvg@mail.gmail.com>
	<20111229215407.GB9737@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36581 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754379Ab1L2WWz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Dec 2011 17:22:55 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RgONB-00015S-Mu
	for linux-omap@vger.kernel.org; Thu, 29 Dec 2011 23:22:53 +0100
Received: from unicorn.mansr.com ([78.86.181.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 29 Dec 2011 23:22:53 +0100
Received: from mans by unicorn.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 29 Dec 2011 23:22:53 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Thu, Dec 29, 2011 at 11:51:11PM +0200, Felipe Contreras wrote:
>> On Thu, Dec 29, 2011 at 11:27 PM, Mark Brown
>> > On Thu, Dec 29, 2011 at 11:25:50PM +0200, Felipe Contreras wrote:
>> >> On Thu, Dec 29, 2011 at 8:37 PM, Mark Brown
>> >> > On Sat, Dec 10, 2011 at 05:59:57PM +0200, Felipe Contreras wrot=
e:
>
>> >> >> It was not working for me, but it seems the problem was relate=
d to
>> >> >> mdev/udev; snd_soc_tlv320aic3x has to be loaded before snd-soc=
-rx51.
>
>> >> > That should not be required, the modules should be loadable in =
any
>> >> > order.
>
>> >> Are you sure? I recall having a similar discussion with Rusell Ki=
ng,
>> >> and the conclusion is that certain modules are supposed to be loa=
ded
>> >> by udev at boot time, and it seems snd_soc_tlv320aic3x is one of =
them.
>
>> > I'm absolutely positive. =A0ASoC supports loading the modules in a=
ny
>> > order. =A0udev is supposed to load anything autoloadable at boot t=
ime,
>> > including I2C devices, but that's orthogonal to the order in which
>> > things actually get loaded - udev can randomly reorder things if i=
t
>> > feels like it.
>
>> Yes, but udev loads snd_soc_tlv320aic3x, not snd-soc-rx51.
>
> That is compltelely orthogonal to what you were saying above about th=
e
> ordering of module loading.
>
> The reason the driver is not loaded automatically is that the OMAP
> machine drivers have not been converted to platform devices.

I posted patches doing the conversion a long time ago (September?).  It
seems they got lost somewhere.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
