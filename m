From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Test code in another git repo? (was Re: simple DMA test module)
Date: Tue, 27 Mar 2007 19:37:28 -0500
Message-ID: <4609B8C8.30204@gmail.com>
References: <4609B203.5070907@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <4609B203.5070907@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Kevin Hilman stated on 3/27/2007 7:08 PM:
> A while back I posted a simple kernel module for testing various ways of
> linking and looping memory-to-memory DMA transfers[1].  I've updated
> that test to work with the current git tree, and it can be found here:
> http://source.mvista.com/~khilman/omap/dmatest.tgz.
>
> I validated on OMAP1 (OSK) and OMAP2 (2430SDP)
>   
Does it make sense to have a git repo with the test code? makes it
accessible to all and a ready reference.. we could pull in from other
trees such as mtd, i2c etc and create a single repository for OMAP test
tree.
Just a suggestion :) esp since I see Kevin spending effort on what Tony
had spend some years back (
http://muru.com/linux/omap/patches/old/patch-2.6.14-omap-dma-test.gz
)... this can feedback to other trees back..

Regards,
Nishanth Menon
