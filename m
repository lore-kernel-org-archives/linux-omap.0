From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 02/11] ARM: OMAP: expose control.h to
	mach area
Date: Mon, 28 May 2012 14:55:07 +0530
Message-ID: <CAMQu2gxbkFCtkK+NCVksC82-R4SAKKtK2w=zNbrNi9a10s1t1Q@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-3-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1337934361-1606-3-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> This patch exposes the definitions under control.h to
> drivers outside the machine code.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
After second thought, this complete header movement needs to avoided.
Drivers should not anyway include something like <mach/control.h>

May be split the control.h header file data into ..
- defines used by mach-omap2/* files which can remain in "control.h"
in existing location.
- common functions/defines used across drivers/*, mach-omap2/*,
plat-omap/*, should
go to include/linux/omap_control.h
- Driver specific defines like thermal, usb etc, should go to
respective drivers file.

What do you think ?

Regards
santosh
