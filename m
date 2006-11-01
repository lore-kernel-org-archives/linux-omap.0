From: tony@atomide.com
Subject: Re: [PATCH] omap-hw: Fix build breakage
Date: Wed, 1 Nov 2006 22:48:07 +0200
Message-ID: <20061101204805.GA6833@atomide.com>
References: <85odrspsc1.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <85odrspsc1.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Arnaud Patard <arnaud.patard@rtp-net.org> [061031 14:58]:
> Hi,
> 
> I've noticed that the omap-hw driver was never updated to take into
> account the mtd changes. As the driver is afaik neither in the mtd tree
> nor in Linus, I'm sending it there.

OK, great.

> I've only brieftly tested it. It builds, detects my nand and allow me to
> read my datas but as the changes are pretty simple, it should be fine.

I'll push it today.

Tony
