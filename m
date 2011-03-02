From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
Date: Wed, 2 Mar 2011 15:42:33 +0100
Message-ID: <AANLkTimdAMLk4scWECNjUmtxKNzd5bBK8VNcLjs8JjBH@mail.gmail.com>
References: <AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>
	<4D6D9B10.9000606@codeaurora.org>
	<4D6D9D06.2020204@bluewatersys.com>
	<4D6D9FC7.1090206@codeaurora.org>
	<4D6DA290.2010607@bluewatersys.com>
	<4D6DAA24.3000204@codeaurora.org>
	<4D6DAE6E.4030701@bluewatersys.com>
	<4D6DB1B1.4060908@codeaurora.org> <4D6DFE67.3020801@stericsson.com>
	<AANLkTimJh_uGP6SYo=9ndz4xiUs1Tbg7z70ng0aFcWyG@mail.gmail.com>
	<20110302113823.GB2728@pulham.picochip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110302113823.GB2728@pulham.picochip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>Daniel Walker <d>
List-Id: linux-omap@vger.kernel.org

2011/3/2 Jamie Iles <jamie@jamieiles.com>:

>> > /sys/devices/system/soc/
>> > /sys/devices/system/soc/unique_id<- Unified way to export an ID for al=
l machs
>>
>> Arbitrary number of bits? Some will have a 64-bit ID, some will have 32-=
bit
>> etc.
>>
>> Should we say it's a hex string of 64 bits?
>
> Could we provide hooks for the platform that takes the buffer and length
> and let the platform do the snprintf()? =A0Our devices have a 128-bit
> serial number and I'm sure there must be others.

Isn't it better to just make it 64-bit so that apps can always parse it,
and then you can have your high-res numbers under mach?

If there is no solid ABI for this there is no point to make it
generic under /soc/unique_id at all.

/soc/name is another useful thing to have I think.

Apart from this we are now en route to the same color of
bikeshed discussion this patchset saw earlier, Maxime please
just implement something that works for you/us so others
can patch in whatever they need on top later.

Yours,
Linus Walleij
