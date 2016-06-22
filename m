From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
Date: Wed, 22 Jun 2016 21:35:55 +0300
Message-ID: <576ADA8B.10404@gmail.com>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <20160621112944.GV29844@pali> <20160621113215.GP22406@atomide.com>
 <201606221848.41305@pali> <20160622175959.GA21075@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160622175959.GA21075@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@baylibre.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 22.06.2016 20:59, Pavel Machek wrote:
>
> ...and graphics acceleration and power management. But who needs
> accelerated graphics, and power management will be solved. So yes,
> N900 is the best phone :-).
>

Well, actually we have SGX out-of-tree driver working (with some 
glitches) with 4.7-rc, Maemo 5 needs it :)

Ivo
