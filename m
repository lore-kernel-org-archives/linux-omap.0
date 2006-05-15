From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Enabling Mistral touch screen driver
Date: Mon, 15 May 2006 19:38:12 +0200
Message-ID: <4468BC84.6050205@gmail.com>
References: <4465A8C0.4020100@nextbitcpu.com> <44675080.1040503@gmail.com>
	<200605140955.53619.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605140955.53619.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
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
> 
> That assumes a recent GIT tree, which includes the board-specific init
> needed to make that work.

Any plans to remove CONFIG_OMAP_UWIRE or 
CONFIG_TOUCHSCREEN_OMAP so that guys like me using their 
configuration for ages are forced to rethink about it?

Dirk
