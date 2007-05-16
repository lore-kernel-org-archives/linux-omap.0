From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [OMAP] [I2C-2430] FIFO Handling support and broken hw
	workaround
Date: Wed, 16 May 2007 15:04:16 -0700
Message-ID: <20070516220415.GD15281@atomide.com>
References: <782515bb0705111748i2116d5bcn45ef17d214978aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <782515bb0705111748i2116d5bcn45ef17d214978aa@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* nishanth menon <menon.nishanth@gmail.com> [070511 17:53]:
> Hi All,
> 
> *) xfers based can use FIFO on FIFO capable devices
> *) Prevents errors for HSI2C if FIFO is not used
> *) Should co-exist with no-FIFO support h/w also
> *) Implemented errenous handling of STT-STP handling on SDP2430

Great, pushing today.

Tony
