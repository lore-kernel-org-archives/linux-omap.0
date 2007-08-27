From: David Brownell <david-b@pacbell.net>
Subject: Re: OSK5912 Boot from CF?
Date: Mon, 27 Aug 2007 12:37:18 -0700
Message-ID: <20070827193718.73D18235133@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <262354.79141.qm@web8503.mail.in.yahoo.com>
	<1188239988.5137.3.camel@localhost.localdomain>
	<46D32043.5070603@googlemail.com>
	<1188241974.5137.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1188241974.5137.7.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: hkh@cypress.com, dirk.behme@googlemail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> How about having the root file system on the CF, and kernel on the NOR
> flash?

That should be easy.

You could even modify U-Boot to understand about that CF controller...
The OMAP would still boot the usual way (from NOR), but current versions
of U-Boot can be told to get the kernel from more places than just NOR
and NET.  That assumes you're willing to hack U-Boot and install/debug
new versions; that's probably not a good new-developer project.

- Dave
