From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Enabling Mistral touch screen driver
Date: Sat, 27 May 2006 08:32:48 +0200
Message-ID: <4477F290.2090402@gmail.com>
References: <4465A8C0.4020100@nextbitcpu.com> <44675080.1040503@gmail.com>
	<200605140955.53619.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200605140955.53619.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
> Erm, we're trying to move away from legacy platform-specific code,
> towards code that's merged/mergeable upstream.
> 
> So instead, use: 
> 
> CONFIG_OMAP_OSK_MISTRAL=y
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_TOUCHSCREEN_ADS7846=y
> CONFIG_SPI_OMAP_UWIRE=y

Just fyi and the archive: Using configuration like above

CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_OMAP_OSK_MISTRAL=y
CONFIG_SPI_BITBANG=m
CONFIG_SPI_OMAP_UWIRE=m

# CONFIG_OMAP_UWIRE is not set
# CONFIG_OMAP_TSC2101 is not set

on recent git works with OMAP5912 OSK. If you use modules, 
don't forget to add 'modprobe omap_uwire' to your 
configuration. This loads spi_bitbang as well. If you don't, 
ads7846 is loaded without any message (ads7846_probe isn't 
called?) and nothing works.

But seems that there is again an irq issue. Seperate mail 
follows.

Best regards

Dirk
