From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC related suspend problems on OMAP3
Date: Wed, 8 Feb 2012 11:51:32 +0000
Message-ID: <20120208115132.GA25756@sirena.org.uk>
References: <CANOLnOMhetqt0ZCCfS0UwnfE0DxLhLhK9=7t0BaQ1SUsv0OWjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CANOLnOMhetqt0ZCCfS0UwnfE0DxLhLhK9=7t0BaQ1SUsv0OWjw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>, lrg@ti.com
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Kevin Hilman <khilman@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 08, 2012 at 02:34:38AM +0200, Grazvydas Ignotas wrote:
> Hi,
> 
> On OMAP3 pandora, system suspend stops working properly after using
> audio at least once:

Also adding Liam to the CC list (and not deleting any context for
visibility).

> 
> (just after boot):
> # echo mem > /sys/power/state
> [   12.578186] PM: Entering mem sleep
> [   12.678802] PM: suspend of devices complete after 92.834 msecs
> [   12.688201] PM: late suspend of devices complete after 3.173 msecs
> [   17.607971] Successfully put all powerdomains to target state
> 
> # aplay /dev/zero
> ^C
> # echo mem > /sys/power/state
> [  104.404663] PM: suspend of devices complete after 78.794 msecs
> [  104.413909] PM: late suspend of devices complete after 3.021 msecs
> [  106.601196] Powerdomain (per_pwrdm) didn't enter target state 1
> [  106.607421] Powerdomain (core_pwrdm) didn't enter target state 1
> [  106.613739] Could not enter target state in pm_suspend
> 
> I'm seeing this on 3.2, unable to verify on current Linus HEAD as
> something else is preventing core/per low power states there.
> Any ideas what could be causing this? Perhaps some clock is left enabled?
> 
> -- 
> Gra??vydas
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
