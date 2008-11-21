From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ASoC: Add support for OMAP3 EVM
Date: Fri, 21 Nov 2008 08:33:27 -0800
Message-ID: <200811210833.27681.david-b@pacbell.net>
References: <1227269463-10114-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1227269463-10114-1-git-send-email-anuj.aggarwal@ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 21 November 2008, Anuj Aggarwal wrote:
> +config SND_OMAP_SOC_OMAP3EVM
> +=A0=A0=A0=A0=A0=A0=A0tristate "SoC Audio support for OMAP3EVM board"
> +=A0=A0=A0=A0=A0=A0=A0depends on SND_OMAP_SOC && MACH_OMAP3EVM

also depends on TWL4030_CORE ... since reverse dependencies
don't work to handle things the "select" target depends on.


> +=A0=A0=A0=A0=A0=A0=A0select SND_OMAP_SOC_MCBSP
> +=A0=A0=A0=A0=A0=A0=A0select SND_SOC_TWL4030
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0Say Y if you want to add support for SoC audio =
on the omap3evm board.
