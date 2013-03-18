From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 0/2] omap serial fix.
Date: Mon, 18 Mar 2013 18:51:29 +0530
Message-ID: <514714D9.1040702@ti.com>
References: <1363604081-11169-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1363604081-11169-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Rajendra nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
On Monday 18 March 2013 04:24 PM, Sourav Poddar wrote:
> The first patch is a rearrangement of a macro "OMAP_MAX_HSUART_PORTS"
> to a header file so that it can be used in other file.
> The second patch fixes the wakeup from uart issue while using "no_console_suspend" in the
> bootargs.
>
> These patches are developed on 3.8 custom kernel containing omap5 supend/resume support.
>
Adding a bit more information,
These patches are not omap5 specific and required for omap4 also.
For OMAP5 testing purpose, I used 3.8 based internal tree.

First patch gets applied cleanly on 3.9-rc3.
Resending the second patch rebased on 3.9-rc3, as there is a small
merge conflict.
> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Cc: Felipe Balbi<balbi@ti.com>
> Cc: Rajendra nayak<rnayak@ti.com>
>
> Sourav Poddar (2):
>    driver: serial-omap: move max uart count into generic header file.
>    arm: mach-omap2: prevent UART console idle on suspend while using
>      "no_console_suspend"
>
>   arch/arm/mach-omap2/omap_device.c         |   36 ++++++++++++++++++++++++++++-
>   drivers/tty/serial/omap-serial.c          |    2 -
>   include/linux/platform_data/serial-omap.h |    1 +
>   3 files changed, 36 insertions(+), 3 deletions(-)
>

