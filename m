From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: TWL6030: Handle power-up seq
 completion thru audio interrupt
Date: Mon, 14 Sep 2009 18:33:28 +0100
Message-ID: <20090914173327.GC2481@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90432709@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90432709@dlee04.ent.ti.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 14, 2009 at 12:00:42PM -0500, Lopez Cruz, Misael wrote:

> CODEC driver starts a wait_for_completion just after calling
> external power-up callback. It's signaled as complete when
> servicing READYINT interrupt.

When you convert to registering as a normal driver you should do this
waiting before registering the CODEC and DAI with the core - that will
stop the ASoC card coming up before the CODEC is ready and means that
you don't need to have a thread sitting blocked on the startup
completing.

> MACHINE drivers should request IRQ line used in corresponding
> hardware platform and initialize workqueue and completion structs
> of twl6030_setup_data as well.

I worry what will happen when someone builds a machine which doesn't
bother hooking up the interrupt line - is it possible to poll for
completion of startup if no interrupt is provided?  If they aren't using
the jack and accessory detect functionality I can see someone not
bothering to hook it up.  OTOH that could always be added later on if
required.
