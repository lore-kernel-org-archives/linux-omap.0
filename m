From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 4/4] ARM: remove duplicate const qualifier
Date: Wed, 27 Apr 2016 16:01:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1604271549270.5091@knanqh.ubzr>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <20160425095715.GA2366@piout.net> <20160425103911.GO32731@imgtec.com>
 <4641918.pNBP5iAK01@wuerfel> <20160425125809.GP32731@imgtec.com>
 <alpine.LFD.2.20.1604250953200.5091@knanqh.ubzr>
 <20160425143731.GR32731@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160425143731.GR32731@imgtec.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Engestrom <eric.engestrom@imgtec.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Roland Stigge <stigge@antcom.de>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Alexander Shiyan <shc_work@mail.ru>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Rajendra Nayak <rnayak@ti.com>, Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, spear-devel@list.st.com, Krzysztof Halasa <khalasa@piap.pl>, Gregory Fong <gregory.0xf0@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@>
List-Id: linux-omap@vger.kernel.org

On Mon, 25 Apr 2016, Eric Engestrom wrote:

> On Mon, Apr 25, 2016 at 10:12:16AM -0400, Nicolas Pitre wrote:
> > Beware.
> > 
> > I added many of those exactly because gcc did not ignore them when 
> > compiling with LTO where the lack of a const qualifier to qualify the 
> > actual array content, and not only the reference to that content, 
> > generated build errors due to section mismatches from the __initconst 
> > annotation.
> 
> I believe the first `const` does that, without the need for a second.
> 
> > So this is a NAK from me unless you may confirm that LTO builds are 
> > unaffected by your changes.
> 
> I can't confirm it (haven't tried), and don't care enough to do it :]
> I guess I'm just dropping the patch then. Like I said, it can't hurt to
> leave them in.

I just tested LTO with your patch applied and everything appears to be 
fine.  The extra const are indeed redundant here. So you have an ACK 
from me.

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
