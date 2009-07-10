From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2:2][MTD][NAND]omap : Adding DMA mode support in nand
	prefetch/post-write
Date: Fri, 10 Jul 2009 13:40:21 +0100
Message-ID: <1247229621.29541.4.camel@macbook.infradead.org>
References: <63362.192.168.10.89.1247226916.squirrel@dbdmail.itg.ti.com>
	<1247227344.20721.363.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1247227344.20721.363.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: dedekind@infradead.org
Cc: vimal singh <vimalsingh@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, david-b@pacbell.net, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2009-07-10 at 15:02 +0300, Artem Bityutskiy wrote:
> On Fri, 2009-07-10 at 17:25 +0530, vimal singh wrote:
> > +	/* The fifo depth is 64 bytes. We have a sync at each frame and frame
> > +	 * length is 64 bytes.
> > +	 */
> > +	int buf_len = len/64;
> 
> To optimize performance it is better not to rely on gcc and use <<

If you ever see gcc screwing up division of an 'int' by a constant 64,
file a GCC bug.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
