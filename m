From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v5 00/16] OMAP2+ OneNAND driver update
Date: Tue, 9 Jan 2018 23:01:14 +0200
Message-ID: <20180109210114.s66rpdg2jjdps5bc@darkstar.musicnaut.iki.fi>
References: <20171115162306.2o2w2yrf7wucroxd@lenoch>
 <20171130111840.41c92d34@bbrezillon>
 <20171130160936.GO28152@atomide.com>
 <434bd733-0ba2-6e75-9de5-017eef905fd2@ti.com>
 <20180109130812.GA338@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180109130812.GA338@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Jan 09, 2018 at 02:08:12PM +0100, Ladislav Michl wrote:
> Merge window is really close now and patches seems still to be untested on
> n8x0. So unless someone is going to test it soon, I'll pick used N800 on
> ebay :-/

Today I tried to test them on Nokia N810, and I get:

[    0.174804] omap-gpmc 6800a000.gpmc: GPMC revision 2.0
[    0.174865] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    0.177459] omap-gpmc 6800a000.gpmc: /ocp/gpmc@6800a000/onenand@0,0 has no 'bank-width' property
[    0.177612] omap-gpmc 6800a000.gpmc: failed to probe DT child 'onenand': -22

With plain v4.15-rc7+ it probes fine.

A.

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
