From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 2/2] MFD: twl6040: Convert to i2c driver,
 and separate it from twl core
Date: Sun, 4 Mar 2012 11:05:34 -0800
Message-ID: <20120304190534.GA22602@core.coreip.homeip.net>
References: <1330418092-12314-1-git-send-email-peter.ujfalusi@ti.com>
	<1330418092-12314-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1330418092-12314-3-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 28, 2012 at 10:34:52AM +0200, Peter Ujfalusi wrote:
> Complete the separation of the twl6040 from the twl core since
> it is a separate chip, not part of the twl6030 PMIC.
> 
> Make the needed Kconfig changes for the depending drivers at the same time to
> avoid breaking the kernel build (vibra, ASoC components).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonicro.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>

For input part:

Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry
