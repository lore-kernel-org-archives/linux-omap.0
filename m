From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: 3.19 on Nokia n900: audio quality awful
Date: Fri, 30 Jan 2015 14:40:06 +0200
Message-ID: <54CB7BA6.2070408@ti.com>
References: <20150106170433.GA5408@amd> <20150118120139.GA1509@amd> <54C63F1C.6010703@ti.com> <54C92752.9000004@bitmer.com> <20150128224144.GA28956@amd> <20150129073529.GA19122@bitmer.com> <54CA173F.1070301@ti.com> <20150130102639.GA19595@amd> <20150130103748.GA24623@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150130103748.GA24623@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, lars@metafoo.de, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

On 01/30/2015 12:37 PM, Pavel Machek wrote:
> Hi!
>=20
>> I looked around the diff between 3.18 and 3.19, reverted these, and
>> audio quality is back to reasonable level.
>=20
> Actually, reverting 368494093354ac613a80c2e1d77602aa12473cf0 seems
> enough.
>=20
> Any quick patches to test? Or should we revert so that 3.19-final
> works ok?

I'll send the fix in a minute, thanks for finding it ;)

--=20
P=E9ter
