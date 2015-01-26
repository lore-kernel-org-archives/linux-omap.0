From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: 3.19 on Nokia n900: audio quality awful
Date: Mon, 26 Jan 2015 15:20:28 +0200
Message-ID: <54C63F1C.6010703@ti.com>
References: <20150106170433.GA5408@amd> <20150118120139.GA1509@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150118120139.GA1509@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

On 01/18/2015 02:01 PM, Pavel Machek wrote:
> Hi!
>=20
> If you have any idea about playback problems, help would be still
> welcome. I'll have to do bisect, otherwise, and it will not be easy.
>=20
>> In 3.18, sound is nice and clear.
>>
>> In 3.19, sound is unusable. It produces nasty tone when it should be
>> quiet, and there's at least as much noise as is sound.
>>
>> Unfortunately, list of mixers also changed (and there's cca 120
>> settings), but a) it does not work with the old list and b) nothing =
I
>> could figure out did make the sound usable. Some setting resulted in
>> even more noise.
>>
>> Any idea what could have caused it?
>=20
> I tried audio recording this time.
>=20
> In 2.6.28-nokia, it is neccessary to set "Input select" na "digital
> mic", then it works. Input select being in "playback" option makes it
> easy to miss.
>=20
> In 3.18 and 3.19-rc3, all I can record are zeros.
>=20
> Does playback/recording work for you on OMAP 3430-based machines?

Same codec (tlv320aic3106) works fine on my am335x and omap-l138 boards=
=2E
BeagleBoard-xM also fine with twl4030 codec.

I don't have my n900 in hacking mode (it is still in use time-to-time) =
but
looking at the dts file: you might want to add ai3x-micbias-vg property=
 to the
aic3x nodes to select the correct mic bias voltage. I can't recall what=
 is
appropriate for n900, but 2.6.28-nokia sources might give you the answe=
r.

--=20
P=E9ter
