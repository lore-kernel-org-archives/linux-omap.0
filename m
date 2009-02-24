From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: Configuring a TWL GPIO pin as an interrupt
Date: Tue, 24 Feb 2009 11:37:47 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705EC8B10D0@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com>
	<200902202112.23307.david-b@pacbell.net>
	<2C7D3DF36ADFFC479B44490D912B616705D61AF093@dlee07.ent.ti.com>
	<200902222326.39232.david-b@pacbell.net>
	<2C7D3DF36ADFFC479B44490D912B616705D632A0EE@dlee07.ent.ti.com>
	<20090223222016.GA6584@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090223222016.GA6584@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: David Brownell <david-b@pacbell.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> If these are CPU side GPIOs that you're talking about you'll 
> also want to write the standard utility for using gpiolib for 
> jack detection that I've not got round to doing yet :)

The GPIOs belong to a submodule of TWL4030, but they are configured
using standard gpiolib.

About adding GPIO functionality to jack detection, if the right
place to request GPIOs and set its data direction is in board files
(arch/*/mach-*/board-*.c), then there won't be much to do in jack
code, only the irq request. Unless we move request and data direction
setting to jack detection layer.

-Misa
