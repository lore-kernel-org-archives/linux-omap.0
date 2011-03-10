From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [RFC PATCHv1 0/2] Export SoC info through sysfs
Date: Thu, 10 Mar 2011 15:05:27 +0200
Message-ID: <20110310130527.GA2154@besouro.research.nokia.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ext Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel
List-Id: linux-omap@vger.kernel.org

Hi,

Back after long silent :-)

On Wed, Mar 09, 2011 at 05:59:19PM +0100, ext Maxime Coquelin wrote:
> Here is the first version of the proposal to export SoC related information to user-space through sysFS interface.
> 
> This serie is to continue what has been discussed on the "socinfo" thread created by Eduardo Valentin:
> https://lkml.org/lkml/2010/5/11/364

Thanks for taking this further. Looks much more promising now :-).

> 
> The first patch introduces the common part, which provides an interface to the platform to register its name, and exports platform-defined IDs to user-space.
> The IDs strings can be provided in two ways: either with a pointer to the string, or by a callback returning the string.

Do you mind refreshing my memory why we need two ways of providing data to these attributes?
I mean, I think if we provide the attribute value during registration time should be enough
and simpler.

Unless you guys are talking about attributes with changes over the time, I don't really see
the need for the callback there. At least from the original scope, I don't see any attributes
which would be exported under soc info which would change over the time.

Or am I missing something?

> 
> The second patch is given as example for the ux500 architecture. It registers with the machine name "DB8500", and exports 3 informations (SoC unique ID, sili
> con revision and silicon process).
> 
> Here is the output for DB8500:
> root@ME:/sys/devices/system/soc ls -l
> -r--r--r--    1 root     root         4096 Jan 11 02:43 mach_name
> -r--r--r--    1 root     root         4096 Jan 11 02:43 process
> -r--r--r--    1 root     root         4096 Jan 11 02:43 revision
> -r--r--r--    1 root     root         4096 Jan 11 02:43 soc_id
> root@ME:/sys/devices/system/soc cat mach_name
> DB8500
> root@ME:/sys/devices/system/soc cat process
> Standard
> root@ME:/sys/devices/system/soc cat revision
> 2.0
> root@ME:/sys/devices/system/soc cat soc_id
> 2ba07ce9e5835d6185321e9577462ef2ea2129cf
> 
> Any comments are welcome.
> 
> Note that I will be off from 13th to 21th of March.
> 
> Regards,
> Maxime
> 
> -------------------------------------------------------------------------------
> 
> Maxime Coquelin (2):
>   Export SoC info through sysfs
>   ux500: Export U8500 SoC info through sysfs
> 
>  arch/arm/mach-ux500/id.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/base/Kconfig     |    4 ++
>  drivers/base/Makefile    |    1 +
>  drivers/base/soc.c       |   88 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h  |   33 ++++++++++++++++
>  5 files changed, 222 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/base/soc.c
>  create mode 100644 include/linux/sys_soc.h

-- 
Eduardo Valentin
