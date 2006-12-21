From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Ensure correct GPIO registers access width.
Date: Thu, 21 Dec 2006 15:42:14 -0800
Message-ID: <20061221234214.GQ10399@atomide.com>
References: <11645731203663-git-send-email-balrog@zabor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11645731203663-git-send-email-balrog@zabor.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com, David Brownell <david-b@pacbell.net>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Andrzej Zaborowski <balrog@zabor.org> [061126 10:31]:
> [Note that this probably gives no gain of any kind.  I don't know
> if it should be applied.]
> 
> Use 16-bit or 32-bit reads and writes to access GPIO registers in
> different banks according to their widths.  Currently all accesses
> in gpio.c were 32-bits.

Let's wait on this a bit. I'd rather have omap1 and omap2 register
their own handlers, so let's plan on doing this along with the generic
gpio framework changes that Dave recently posted to LKML.

Regards,

Tony
