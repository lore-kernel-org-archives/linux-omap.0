From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: [alsa-devel] [PATCHv2 5/7] ASoC: TWL6030: Add support for
	low-power mode
Date: Tue, 29 Sep 2009 22:02:49 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90AE80EC@dlee04.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391E3@dlee04.ent.ti.com>
 <20090928132800.GD31899@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46801 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbZI3DCx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 23:02:53 -0400
In-Reply-To: <20090928132800.GD31899@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Mark,

Mark Brown wrote:
> On Fri, Sep 25, 2009 at 09:03:30PM -0500, Lopez Cruz, Misael wrote:
> 
>> TWL6030 codec supports two power modes: low-power and high
>> performance.

>> In low-power mode, headset downlink must be the only path enabled
>> and components in that path (headset DAC and driver) should be in
>> that mode too. In this mode, codec can stream audio at 44.1 and
>> 48 kHz if sys clock from CLK32K is configured to 17.64 and 19.2
>> MHz using low-power PLL, respectively.

>> In high-performance mode, codec can only work at 19.2 MHz from
>> high-performance PLL. All paths supported in the codec can be used
>> but audio can be streamed only at 48 kHz.

> The driver should also set constraints at runtime so that applications
> know they shouldn't use an unsupported sample rate.  See wm8988 for an
> example of doing this - it has some similar SYSCLK based restrictions.

I think I got confused with what to do in set_sysclk and set_pll. In my
current approach:

- set_sysclk takes care of setting corresponding clk source: lppll
  or hppll. But it also disables the pll not in use (i.e. if lppll is
  set, then disable hppll)
- set_pll takes care of setting pll div for lppll (which is meant to
  receive 32k clk) and configure hppll for any of the supported freq_in
  (12, 19.2, 26, 38.4 MHz). Because only after this point I know the
  value of sysclk, the constraints are set here. Is it fine?
  For lppll the sysclk is set to requested freq_out (if div value is
  in the valid range) and for hppll it's always 19.2 and it's the only
  clk rate support by that pll.

In contrast, in wm8988 the sysclk and contraints are set directly in
set_sysclk.

I have been kind of insecure about all these clk configuration, so I'd
be great if you could explain what's expected to go in set_sysclk as well
as in set_pll.

> It also strikes me that this is something that should be
> exposed to user space since if there's a 19.2MHz MCLK it's something
> that the system could reasonably want to activate and deactivate on
> the fly.

> For bonus points the driver could prevent switching to low power
> mode if any paths are active which conflict with it.  Doing it
> automatically would be ideal but since it sounds like a performance
> degradation to use low power mode that's not really suitable.

Any suggestion on how to detect the active paths? Using widgets with
events?
The only path active to switch to low-power should be headset.

Thanks,
-Misa