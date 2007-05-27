From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: write memory barrier
Date: Mon, 28 May 2007 01:15:11 +0300
Message-ID: <1180304111.3430.31.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP ml <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,
I am wondering if/when i should use a barrier: I am changing the
settings of the dividers and such operation requires writing to
prcm_clkcfg_ctrl after programminig the new set of dividers.

So far it seems to work without barriers, but i'm wodering if i'm just
been lucky, while the OMAP2 TRM seems to refer only to interacting with
the INTC, when referrinig to memory barriers.

I have also checked the ARM1136 TRM but couldn't find anything that
would seem to be related to my problem.

Thanks in advance for any info.

-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
