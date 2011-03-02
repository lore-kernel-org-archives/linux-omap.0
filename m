From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
Date: Wed, 2 Mar 2011 11:36:38 +0100
Message-ID: <AANLkTimJh_uGP6SYo=9ndz4xiUs1Tbg7z70ng0aFcWyG@mail.gmail.com>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>
	<AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>
	<20110216115729.GA29817@besouro.research.nokia.com>
	<4D6B78BF.1020102@stericsson.com> <4D6C7B56.9060109@codeaurora.org>
	<AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>
	<4D6D9B10.9000606@codeaurora.org>
	<4D6D9D06.2020204@bluewatersys.com>
	<4D6D9FC7.1090206@codeaurora.org>
	<4D6DA290.2010607@bluewatersys.com>
	<4D6DAA24.3000204@codeaurora.org>
	<4D6DAE6E.4030701@bluewatersys.com>
	<4D6DB1B1.4060908@codeaurora.org> <4D6DFE67.3020801@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4D6DFE67.3020801@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, Rabin VINCENT <rabin.vincent@stericsson.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Walker <dwalker@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Andrei Warkentin <andreiw@motorola.com>P
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 2, 2011 at 9:23 AM, Maxime Coquelin
<maxime.coquelin-nonst@stericsson.com> wrote:

> I think we should have a tree like this :
>
> /sys/devices/system/soc/
> /sys/devices/system/soc/unique_id<- Unified way to export an ID for all machs

Arbitrary number of bits? Some will have a 64-bit ID, some will have 32-bit
etc.

Should we say it's a hex string of 64 bits?

> /sys/devices/system/soc/mach/
> /sys/devices/system/soc/mach/name<- Name of the mach
> /sys/devices/system/soc/mach/foo_id
> /sys/devices/system/soc/mach/bar_id<- Vendors may have several/different IDs
> to export (IDCODE for OMAP, Production ID...)

For Ux500 we can export the stuff we print today in mach-ux500/id.c,
put in place earlier by Rabin, I'd prefer if you hook in the new ID stuff
there as well, since it's so little platform code, and a logical place to
have it in.

> Linus, do you agree?

Yeah, sounds good.

Yours,
Linus Walleij
