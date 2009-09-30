From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 5/7] ASoC: TWL6030: Add support for
 low-power mode
Date: Wed, 30 Sep 2009 11:12:06 +0100
Message-ID: <20090930101206.GA15721@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391E3@dlee04.ent.ti.com>
	<20090928132800.GD31899@rakim.wolfsonmicro.main>
	<67059DBF19D7214F9C66BB0EA91BA90E90AE80EC@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90AE80EC@dlee04.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 29, 2009 at 10:02:49PM -0500, Lopez Cruz, Misael wrote:

> I think I got confused with what to do in set_sysclk and set_pll. In my
> current approach:
> 
> - set_sysclk takes care of setting corresponding clk source: lppll
>   or hppll. But it also disables the pll not in use (i.e. if lppll is
>   set, then disable hppll)
> - set_pll takes care of setting pll div for lppll (which is meant to
>   receive 32k clk) and configure hppll for any of the supported freq_in
>   (12, 19.2, 26, 38.4 MHz). Because only after this point I know the
>   value of sysclk, the constraints are set here. Is it fine?
>   For lppll the sysclk is set to requested freq_out (if div value is
>   in the valid range) and for hppll it's always 19.2 and it's the only
>   clk rate support by that pll.

Hrm.  Is it actually worth having manual configuration of the PLL
(beyond selection of the PLL to use), or could the driver figure out the
required output frequency for lppll?  Either way is fine from an ASoC
point of view, it's just that if the driver can figure the configuration
out for itself that makes it a little easier to use.

In any case...

> In contrast, in wm8988 the sysclk and contraints are set directly in
> set_sysclk.

Note that they're actually passed to ALSA when the substreams are opened
- all that wm8988 is doing in set_sysclk() is recording the constraints
that it will use next time that happens.  Up until the point where you
tell ALSA about the constraints you can do pretty much whatever you like
so long as it makes sense, so what you say above is probably fine.  For
the wm8988 there's no PLL so once the input clock is known there's
nothing more to do for it.
