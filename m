From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/4] SOUND: SOC: OMAP: Add support for
	Gumstix Overo
Date: Tue, 2 Sep 2008 12:29:37 +0100
Message-ID: <20080902112936.GC25176@sirena.org.uk>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com>
	<1220306279-27977-2-git-send-email-sakoman@gmail.com>
	<1220306279-27977-3-git-send-email-sakoman@gmail.com>
	<1220306279-27977-4-git-send-email-sakoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1220306279-27977-4-git-send-email-sakoman@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sakoman@gmail.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 01, 2008 at 02:57:58PM -0700, sakoman@gmail.com wrote:

> Signed-off-by: Steve Sakoman <steve@sakoman.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

though obviously it depends on the codec driver going in and there's one
nit that should be fixed:

>  # OMAP Machine Support
>  snd-soc-n810-objs := n810.o
> +snd-soc-omap3evm-objs := omap3evm.o
> +snd-soc-omap3beagle-objs := omap3beagle.o
> +snd-soc-overo-objs := overo.o

Looks like some extra stuff crept in here...
