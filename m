From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ALSA: Fix OMAP24xx EAC codec port I2S master/slave
	support
Date: Thu, 26 Apr 2007 18:08:12 +0000
Message-ID: <20070426180811.GD9764@atomide.com>
References: <20070404141305.555e4dd1.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070404141305.555e4dd1.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [070404 11:15]:
> - Add explicit I2S master and slave modes
> - Do not configure bit-clock and frame sync direction according to polarity
>   changed I2S mode as it was done in programming model but according to
>   master/slave mode
> - Activate codec port transparent DMA only when EAC is I2S slave

Pushing today.

Tony
