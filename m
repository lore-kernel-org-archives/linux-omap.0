From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Configuring a TWL GPIO pin as an interrupt
Date: Tue, 24 Feb 2009 18:46:14 +0000
Message-ID: <20090224184612.GA7121@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com>
	<200902202112.23307.david-b@pacbell.net>
	<2C7D3DF36ADFFC479B44490D912B616705D61AF093@dlee07.ent.ti.com>
	<200902222326.39232.david-b@pacbell.net>
	<2C7D3DF36ADFFC479B44490D912B616705D632A0EE@dlee07.ent.ti.com>
	<20090223222016.GA6584@sirena.org.uk>
	<2C7D3DF36ADFFC479B44490D912B616705EC8B10D0@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705EC8B10D0@dlee07.ent.ti.com>
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
Cc: David Brownell <david-b@pacbell.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 24, 2009 at 11:37:47AM -0600, Lopez Cruz, Misael wrote:

> About adding GPIO functionality to jack detection, if the right
> place to request GPIOs and set its data direction is in board files
> (arch/*/mach-*/board-*.c), then there won't be much to do in jack
> code, only the irq request. Unless we move request and data direction
> setting to jack detection layer.

No, do that in the jack code.  The board code should only be doing
things like putting the pins into GPIO mode (if that's not the default)
and any other steps required to ensure that they don't do anything like
consume a lot of power without the audio driver loaded.
