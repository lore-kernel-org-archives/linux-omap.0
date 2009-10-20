From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] MFD: twl4030: add twl4030_codec MFD as
	a new child	to the core
Date: Tue, 20 Oct 2009 11:03:34 +0100
Message-ID: <20091020100334.GA28592@opensource.wolfsonmicro.com>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255956140-4829-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1255956140-4829-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 19, 2009 at 03:42:17PM +0300, Peter Ujfalusi wrote:
> New MFD child to twl4030 MFD device.
> This MFD device will be used by the drivers, which needs resources
> from the twl4030 codec like audio and vibra.

> The platform specific configuration data is passed along to the
> child drivers (audio, vibra).

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

> +config TWL4030_CODEC
> +	bool "Support codec part of the TWL4030 family chips"

This seems like something that users shouldn't really have to worry
about selecting explicitly - might it be better to have it selected by
the drivers that use it instead?  It feels like it's an implementation
detail of the driver.
