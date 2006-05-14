From: David Brownell <david-b@pacbell.net>
Subject: Re: Enabling Mistral touch screen driver
Date: Sun, 14 May 2006 09:55:52 -0700
Message-ID: <200605140955.53619.david-b@pacbell.net>
References: <4465A8C0.4020100@nextbitcpu.com> <44675080.1040503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <44675080.1040503@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sunday 14 May 2006 8:45 am, Dirk Behme wrote:
> 
> Kernel configuration for this:
> 
> CONFIG_OMAP_OSK_MISTRAL=y
> CONFIG_OMAP_UWIRE=y
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_TOUCHSCREEN_OMAP=y

Erm, we're trying to move away from legacy platform-specific code,
towards code that's merged/mergeable upstream.

So instead, use: 

CONFIG_OMAP_OSK_MISTRAL=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=y
CONFIG_SPI_OMAP_UWIRE=y

That assumes a recent GIT tree, which includes the board-specific init
needed to make that work.

- Dave
