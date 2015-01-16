From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: OMAP: mcbsp: ensure that CLKX and
 CLKR are not used as ouput pins when they are used as input clock for the
 SRG.
Date: Fri, 16 Jan 2015 11:09:04 +0200
Message-ID: <20150116090904.GA8247@bitmer.com>
References: <1421360901-20671-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1421360901-20671-1-git-send-email-niederp@physik.uni-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

On Thu, Jan 15, 2015 at 11:28:21PM +0100, Thomas Niederpr=FCm wrote:
> This patch fixes faulty behaviour in a setup where the input clock for
> the SRG is fed through the CLKR pin but the McBSP is configured to be
> master (SND_SOC_DAIFMT_CBS_CFS). In that case of course CLKR must not be
> configured as output pin. Otherwise the input clock is messed up
> horribly. The same reasoning applies if CLKX is configured as input for
> the SRG.
> =

> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> ---
>  sound/soc/omap/omap-mcbsp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> =

I cannot check at the moment but is this actually a contradictory
configuration if McBSP is set to bit clock master but at the same want
to use it as an input also? Should you use SND_SOC_DAIFMT_CBM_CFS
instead?

Peter: care to check?

-- =

Jarkko
