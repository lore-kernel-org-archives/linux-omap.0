From: David Brownell <david-b@pacbell.net>
Subject: Re: [01/17 PATCH] MMC: OMAP: Introduces new structures for MMC
	multislot support.
Date: Fri, 17 Aug 2007 14:55:15 -0700
Message-ID: <200708171455.15439.david-b@pacbell.net>
References: <46C5F08D.7070207@indt.org.br>
	<200708171445.28921.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200708171445.28921.david-b@pacbell.net>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Friday 17 August 2007, David Brownell wrote:
> On Friday 17 August 2007, Carlos Aguiar wrote:
> > Introduces new structures for MMC multislot support.
> 
> Seems like #1 and #2 should be a single patch, since
> after #1 it won't compile ...

... and maybe #3, and ... ?

Also, this doesn't look to me primarily like "multislot"
support.  It's also "stop relying on GPIOs" for various
things that newer boards handle with external chips
(like CD and WP switches), and "move board-specific code
out of the MMC driver"...

- Dave
