From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/13] PM: QoS: rename pm_qos_params files to
	pm_qos
Date: Fri, 29 Jul 2011 23:57:48 +0200
Message-ID: <201107292357.48969.rjw@sisk.pl>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1311841821-10252-2-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jean.pihet@newoldbits.com
Cc: markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday, July 28, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> The PM QoS implementation files are better named
> kernel/pm_qos.c and include/linux/pm_qos.h.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-msm/clock.c              |    2 +-
>  drivers/acpi/processor_idle.c          |    2 +-
>  drivers/cpuidle/cpuidle.c              |    2 +-
>  drivers/cpuidle/governors/ladder.c     |    2 +-
>  drivers/cpuidle/governors/menu.c       |    2 +-
>  drivers/media/video/via-camera.c       |    2 +-
>  drivers/net/e1000e/netdev.c            |    2 +-
>  drivers/net/wireless/ipw2x00/ipw2100.c |    2 +-
>  drivers/staging/msm/lcdc.c             |    2 +-
>  drivers/staging/msm/tvenc.c            |    2 +-
>  include/linux/netdevice.h              |    2 +-
>  include/linux/pm_qos.h                 |   38 +++
>  include/linux/pm_qos_params.h          |   38 ---
>  include/sound/pcm.h                    |    2 +-
>  kernel/Makefile                        |    2 +-
>  kernel/pm_qos.c                        |  481 ++++++++++++++++++++++++++++++++
>  kernel/pm_qos_params.c                 |  481 --------------------------------
>  net/mac80211/main.c                    |    2 +-
>  net/mac80211/mlme.c                    |    2 +-
>  net/mac80211/scan.c                    |    2 +-
>  sound/core/pcm_native.c                |    2 +-
>  21 files changed, 536 insertions(+), 536 deletions(-)
>  create mode 100644 include/linux/pm_qos.h
>  delete mode 100644 include/linux/pm_qos_params.h

That I agree with.

>  create mode 100644 kernel/pm_qos.c
>  delete mode 100644 kernel/pm_qos_params.c

As I said, please move that file to kernel/power and call it qos.c.

That said the device interface should be located in drivers/base/power
to follow our current conventions.

Thanks,
Rafael
