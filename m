From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: McBSP functions not exported
Date: Wed, 16 Jan 2013 10:05:57 +0100
Message-ID: <50F66D75.6030704@ti.com>
References: <20130111114846.00005679@unknown> <50F010CF.8020808@ti.com> <ebad79c2234bac82958b7a1deea3ae55@localhost> <50F3C648.60101@ti.com> <f358e8045003700c83717ce3f7bc1932@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58986 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141Ab3APJGK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jan 2013 04:06:10 -0500
In-Reply-To: <f358e8045003700c83717ce3f7bc1932@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Barker <paul@paulbarker.me.uk>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hi,

On 01/15/2013 06:43 PM, Paul Barker wrote:
> I've written a quick driver which issues SPI reads in response to hrt=
imer events
> to see if this is possible. I'm getting a rough average latency of 10=
0us between
> calling spi_async() and the clock signal changing. This is no use for=
 reading a
> single sample at a time at a rate of 625kHz. Even ignoring this probl=
em, I
> imagine there would be at least a few microseconds of latency between=
 a GPIO pin
> changing and an interrupt handler being executed by the kernel. My tr=
ansfer
> takes 1us and I have a new data word every 1.6us. So I think issuing =
single SPI
> read requests each time I get an interrupt isn't going to work for me=
=2E
>=20
> With the hrtimer interval set to 1.6us my board completely locks up (=
probably
> has no free time to handle anything else). I don't think Linux was de=
signed to
> respond to these sorts of requests in real-time. I need to offload th=
is to the
> DMA system, but I can't see any way to do that (with a 600ns gap betw=
een
> transfers) using the Linux SPI API.

McSPI can also use DMA. You need to have >160 bytes in one transfer to =
use the
sDMA. Under 160 bytes the drivers switches to PIO mode.

To understand your setup: how did you wired the ADS1672 with McBSP?
I assume that McBSP is slave. ADS's CS is grounded, SCLK_SEL is 0, you =
use the
DRDY signal as FS and configure the McBSP in kind of DSP (or PCM mode) =
to read
the data.

McSPI can be used in this mode. When McSPI is slave it looks for the ed=
ge on
the CS0 line. This can be the DRDY signal. It will start to shift in th=
e data
when it detect the edge. According to the ADS datasheet it generates th=
e DRDY
signal (pulse) before when the data is available.
So if you hook up the ADS with McSPI:
McSPI is slave, DRDY is used as CS0, clock is coming from ADS, you prep=
are a
transfer for more than 160 bytes (McSPI can handle 65535 words in a tra=
nsfer).
This case you will offload the read to sDMA. You will be notified when =
the
message has been retrieved, you can place another read and while you ar=
e
collecting data you can process the already received buffer.

Or as Jarkko already mentioned there might be a way to use ALSA API fro=
m
userspace to fetch the data.

>> I don't see how it could help custom boards. For audio all boards ca=
n just
>> happily use the McBSP stack + omap-pcm. It could help with boards wh=
ere the
>> McBSP is not used for audio. But I think those users could use McSPI=
 instead
>> of McBSP for their needs.
>>
>> As a sidenote: The support for SPI like protocols in McBSP only exis=
ted on
>> OMAP1 where we had a stop clocks possibility. In all latest versions=
 of OMAP
>> removed this possibility and McBSP officially only supports I2S, PCM=
, TDM
>> protocols. This was another reason to move the McBSP under sound.
>=20
> The ADS1672 shouldn't care if the clock stops or not, it has the abil=
ity to
> output its own clock signal and that runs continuously.
>=20
> My understanding of the McBSP using DMA is that a read would be issue=
d as soon
> as a frame sync pulse is detected, with no processor involvement, and=
 I can get
> an interrupt from the DMA controller once every few thousand samples =
or so and
> so the OS can just get on with running in the meantime. It looks like=
 that is
> what I need to happen here.
>=20
> I'm going to go back to using kernel 3.2 and check that this actually=
 works
> with the McBSP. If it does, how much hassle is it to export the requi=
red symbols
> in more recent kernels? I'll happily write the patch, I just don't wa=
nt to
> introduce too much more maintenance overhead going forward.
>=20
> Thanks,
>=20
> Paul Barker


--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
