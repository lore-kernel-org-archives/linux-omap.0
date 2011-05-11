From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Remove restrictive
	checks for cpu type
Date: Wed, 11 May 2011 15:57:08 +0200
Message-ID: <20110511135708.GE12469@opensource.wolfsonmicro.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1305122135-27938-1-git-send-email-premi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sanjeev Premi <premi@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 11, 2011 at 07:25:35PM +0530, Sanjeev Premi wrote:
> Current checks for cpu type were too restrictive leading
> to failures for other silicons in same family.
> 
> The problem was found while testing audio playback on
> AM37x and AM35x processors. But should exist on OMAP36xx
> as well.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
