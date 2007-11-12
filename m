From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: Move 32k-based sched_clock() to common
	code
Date: Mon, 12 Nov 2007 12:00:06 -0800
Message-ID: <1194897606.3334.3.camel@vence.hilman.org>
References: <20071112182209.262757465@mvista.com>
	<20071112182311.499470805@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-FusTgwXc73pMVmv4LPub"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071112182311.499470805@mvista.com>
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


--=-FusTgwXc73pMVmv4LPub
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, 2007-11-12 at 10:22 -0800, Kevin Hilman wrote:

> Since 32k timer code is moving to OMAP1 specific dir, move the
> 32k-based sched_clock() into common code where it is based on the 32k
> sync counter and can be used even when using MPU timer.
> 
> While moving change the ticks-to-nsecs conversion to use the helper
> functions provided by clocksource.h.
> 
> Also removed the unused ticks_to_usec, leaving only ticks_to_nsec.
> 

Update for OMAP1:  Make sched_clock() weak MPU version wins if enabled.

Kevin


--=-FusTgwXc73pMVmv4LPub
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-FusTgwXc73pMVmv4LPub--
