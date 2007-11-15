From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH/RFC 0/3 rev 3] I2C bus registration helper
Date: Thu, 15 Nov 2007 13:57:49 -0800
Message-ID: <20071115215748.GR20686@atomide.com>
References: <1194432873-5209-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1194432873-5209-1-git-send-email-jarkko.nikula@nokia.com>
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

* Jarkko Nikula <jarkko.nikula@nokia.com> [071107 03:02]:
> Third version of I2C bus registration helper. Now omap_i2c_mux_pins
> is supposed to stay here for doing pin muxing for I2C as suggested by David
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-November/011906.html
> 
> Patch 2 differs only in board-h4.c where omap_cfg_reg calls are removed.
> Patch 3 is the same than previously.

Pushing this series today.

Tony
