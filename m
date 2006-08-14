From: Jonathan McDowell <noodles@earth.li>
Subject: Re: Framebuffer status in latest git?
Date: Mon, 14 Aug 2006 17:09:52 +0100
Message-ID: <20060814160952.GM27094@earth.li>
References: <20060811151401.GT27094@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060811151401.GT27094@earth.li>
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

On Fri, Aug 11, 2006 at 04:14:01PM +0100, Jonathan McDowell wrote:
> I'm finding the framebuffer isn't working in latest git, but does in
> 2.6.17-omap2. I can't see any changes in drivers/video/omap between the
> two. Is anyone else experiencing this (or is anyone successfully using
> the framebuffer with latest git)?
> 
> (This is on the Amstrad Delta, so OMAP150, with a patch that isn't yet
> in git but is the same for both 2.6.17-omap2 and latest git - I was in
> the process of making sure it still worked so I could submit it.)

Ok. This seems to work fine if I actually complete a boot (I'm having
other issues with the new MTD OOB code that means my rootfs isn't
workin), so it looks like something else is just causing the screen to
blank when there's an issue.

J.

-- 
                                            jid: noodles@jabber.earth.li
"Bother," said Pooh, as he was buried
                                            alive.
