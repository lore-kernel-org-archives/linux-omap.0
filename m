From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix broken N770 build
Date: Sat, 11 Nov 2006 07:07:17 +0100
Message-ID: <45556895.8080008@gmail.com>
References: <454F7F77.8000302@gmail.com> <20061111000316.GN26185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061111000316.GN26185@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> Also left out the defconfig changes as they
> don't seem to do anything. Let me know if something is needed
> on the defconfig.

In -rc4 CONFIG_HWMON wasn't evaluated to y necessary to 
build stuff cleanly. Seems that in -rc5 this is fixed. Now, 
CONFIG_HWMON is default y and n770_defconfig builds fine 
without the defconfig patch.

Thanks for updates,

Dirk

Btw: Last warning I see with n770_defconfig in our code is

arch/arm/plat-omap/sti/sti-console.c: In function 
'sti_channel_puts':
arch/arm/plat-omap/sti/sti-console.c:48: warning: value 
computed is not used
arch/arm/plat-omap/sti/sti-console.c:57: warning: value 
computed is not used

Anybody with an idea here?
