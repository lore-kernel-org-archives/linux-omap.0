From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/10] ASoC: OMAP4: Rename the sdp4430
	machine driver
Date: Wed, 14 Dec 2011 18:22:30 +0800
Message-ID: <20111214102228.GG3072@opensource.wolfsonmicro.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
	<1323856022-24053-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1323856022-24053-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 14, 2011 at 11:46:55AM +0200, Peter Ujfalusi wrote:
> The same machine driver will support other boards
> with similar audio configuration (OMAP4, ABE, twl6040).
> Rename the driver to have more generic name.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Though given that ABE is part of the OMAP4 silicon it seems silly to
include it in the name, it's like calling it omap4-abe-mcpdm- and so on.
