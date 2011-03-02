From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
Date: Wed, 2 Mar 2011 15:18:14 +0000
Message-ID: <20110302151814.GA2919@pulham.picochip.com>
References: <4D6D9D06.2020204@bluewatersys.com>
	<4D6D9FC7.1090206@codeaurora.org>
	<4D6DA290.2010607@bluewatersys.com>
	<4D6DAA24.3000204@codeaurora.org>
	<4D6DAE6E.4030701@bluewatersys.com>
	<4D6DB1B1.4060908@codeaurora.org> <4D6DFE67.3020801@stericsson.com>
	<AANLkTimJh_uGP6SYo=9ndz4xiUs1Tbg7z70ng0aFcWyG@mail.gmail.com>
	<20110302113823.GB2728@pulham.picochip.com>
	<AANLkTimdAMLk4scWECNjUmtxKNzd5bBK8VNcLjs8JjBH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimdAMLk4scWECNjUmtxKNzd5bBK8VNcLjs8JjBH@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Jamie Iles <jamie@jamieiles.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 02, 2011 at 03:42:33PM +0100, Linus Walleij wrote:
> 2011/3/2 Jamie Iles <jamie@jamieiles.com>:
> =

> >> > /sys/devices/system/soc/
> >> > /sys/devices/system/soc/unique_id<- Unified way to export an ID for =
all machs
> >>
> >> Arbitrary number of bits? Some will have a 64-bit ID, some will have 3=
2-bit
> >> etc.
> >>
> >> Should we say it's a hex string of 64 bits?
> >
> > Could we provide hooks for the platform that takes the buffer and length
> > and let the platform do the snprintf()? =A0Our devices have a 128-bit
> > serial number and I'm sure there must be others.
> =

> Isn't it better to just make it 64-bit so that apps can always parse it,
> and then you can have your high-res numbers under mach?
> =

> If there is no solid ABI for this there is no point to make it
> generic under /soc/unique_id at all.

I guess I'd argue that a arbitrary length hex string could be considered =

as a solid ABI but you're right that it's probably more important to get =

something out there and I'm probably being too picky, so apologies!

Jamie
