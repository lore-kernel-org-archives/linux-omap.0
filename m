From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/7][RESEND] ARM: OMAP1: ams-delta:
	register latch	dependent devices later
Date: Tue, 20 Dec 2011 20:40:46 +0000
Message-ID: <20111220204046.GA3354@n2100.arm.linux.org.uk>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
	<83e934adfc691b347534edb7788a67ab2e6bd7e1.1324331816.git.jkrzyszt@tis.icnet.pl>
	<201112200028.32947.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <201112200028.32947.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 20, 2011 at 12:28:32AM +0100, Janusz Krzysztofik wrote:
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index d4d08bd..56ffd7c 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -165,6 +165,9 @@ serio:
>  	kfree(ams_delta_serio);
>  	return err;
>  }
> +#ifndef MODULE
> +late_initcall(ams_delta_serio_init);
> +#else
>  module_init(ams_delta_serio_init);
>  
>  static void __exit ams_delta_serio_exit(void)
> @@ -175,3 +178,4 @@ static void __exit ams_delta_serio_exit(void)
>  	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
>  }
>  module_exit(ams_delta_serio_exit);
> +#endif

It's worth noting:

#ifndef MODULE
#define late_initcall(fn)               __define_initcall("7",fn,7)
#else /* MODULE */
#define late_initcall(fn)               module_init(fn)

So really, all these ifndefs aren't required.  Just change the module_init()
to late_initcall().
