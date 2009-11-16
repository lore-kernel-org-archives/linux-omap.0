From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] input: touchscreen: introduce tsc2005 driver
Date: Mon, 16 Nov 2009 15:23:55 +0000
Message-ID: <20091116152354.GA29479@sirena.org.uk>
References: <1257340982-22814-1-git-send-email-aaro.koskinen@nokia.com> <20091114060332.GG4463@core.coreip.homeip.net> <20091116123748.GC28963@pcarmody-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091116123748.GC28963@pcarmody-desktop>
Sender: linux-input-owner@vger.kernel.org
To: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Koskinen Aaro (Nokia-D/Helsinki)" <aaro.koskinen@nokia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Leukkunen Lauri (Nokia-D/Helsinki)" <lauri.leukkunen@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, "Deak Imre (Nokia-D/Helsinki)" <imre.deak@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Tereshonkov Roman (Nokia-D/Helsinki)" <roman.tereshonkov@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 16, 2009 at 02:37:48PM +0200, Phil Carmody wrote:
> On 14/11/09 07:03 +0100, ext Dmitry Torokhov wrote:

> > Do we really need to do filtering and averaging in kernel? What about
> > tslib?

> Not everyone uses tslib. There's already some filtering in the tsc2005 
> already, but it's not really enough. This averaging also has the
> pleasant side-effect of reducing the number of input events. The
> fudging that takes place later has slightly different smoothing
> behaviour, and isn't a substitute.

If we do want to be doing filtering and averaging in kernel then it
really ought to be some sort of generic framework rather than driver
specific code since otherwise there will be duplication of effort.  The
OpenMoko guys were pushing a framework for doing that, I'm not sure what
the current status is.
