From: Jeff DeFouw <jeffd@i2k.com>
Subject: Re: NAND misreads on omap beagle and overo
Date: Fri, 29 Jan 2010 12:21:46 -0500
Message-ID: <20100129172146.GA4476@blorp.plorb.com>
References: <20100129081027.GA13915@blorp.plorb.com>
	<ce9ab5791001290026y37f6ba09i5a565d62a7716c1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <ce9ab5791001290026y37f6ba09i5a565d62a7716c1c@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 29, 2010 at 01:56:59PM +0530, Vimal Singh wrote:
> I did not went through complete mail. Still, you may want to try this patch:
> <http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commitdiff/dcb2469bdd3d12f760bae509f86b4069081a99c5>

I disabled prefetch after the first few tests to make sure this wasn't 
an issue.

-- 
Jeff DeFouw <jeffd@i2k.com>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
