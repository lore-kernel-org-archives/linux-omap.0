From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 RESEND] ASoC: Fix resource reclaim for
	osk5912
Date: Thu, 25 Nov 2010 21:47:20 +0000
Message-ID: <20101125214718.GA26792@opensource.wolfsonmicro.com>
References: <1290608641.2235.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1290608641.2235.5.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Charulatha <charu@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 24, 2010 at 10:24:01PM +0800, Axel Lin wrote:
> In current implementation, there are resources leak in the error path.
> This patch properly reclaims the allocated resources in the error path.
> 
> Also adds a missing clk_put in osk_soc_exit.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Applied, thanks.
