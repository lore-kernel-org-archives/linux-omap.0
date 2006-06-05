From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Plea for MMC spec owners
Date: Mon, 05 Jun 2006 10:52:26 +0200
Message-ID: <4483F0CA.70308@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Sorry for being a bit off topic, but this was the venue suggested to me
to get in touch with the required people.

Myself and Russell King (the MMC layer maintainer) have been discussing
a way to resolve the issue with 2GB+ cards that more and more users are
reporting.

The issue that is causing us grief is whether or not it's safe to always
use a sector size of 512 bytes. The card specs we have give conflicting
information, so we'd like to find someone who has access to the official
protocol spec and can check the exact wording. I was told that some of
the Nokia folks, who have been helpful in checking the offical spec
before, hang around here.  :)

What is needed is the exact definition of READ_BL_PARTIAL and
WRITE_BL_PARTIAL.

Thanks
Pierre
