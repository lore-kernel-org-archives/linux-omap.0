From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Update omap_h2_1610_defconfig
Date: Tue, 9 Jan 2007 15:17:09 -0800
Message-ID: <20070109231708.GG7384@atomide.com>
References: <459D1F62.6020506@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <459D1F62.6020506@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070104 07:38]:
> 
> ARM: OMAP: Update omap_h2_1610_defconfig. Besides update
> main reason is to switch JFFS2_FS_DEBUG debug level from 2
> to 0 because JFFS2 debug seems to be broken (doesn't compile
> with level 2 enabled). At defconfig we don't need JFFS2
> debug enabled, enable it locally if needed.

Pushing today.

Tony
