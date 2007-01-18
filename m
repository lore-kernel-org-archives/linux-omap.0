From: David Brownell <david-b@pacbell.net>
Subject: [patch 0/3] musb_hdrc, remove MGC_{Read,Write}Csr{8,16}
Date: Thu, 18 Jan 2007 15:35:07 -0800
Message-ID: <200701181535.08332.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Folowing this are three patches removing those annoying CaMeLcAsE
macros cluttering up the sources ... this is the last significant
such fix that's needed IMO, although certainly struct members,
variables, and function/procedure parameters can be cleaned up.

Given that, issues I know about on the musb_hdrc code in GIT right
now, observed on tusb6010 but not tested on DaVinci, include:

 - Hmm, host side was not enumerating ... new failure
 - DMA wierdness of various types
 - Various issues with suspend states and remote wakeup

That list is just so anyone running into them needn't be too
surprised.

- Dave
