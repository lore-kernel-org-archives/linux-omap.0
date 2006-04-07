From: Komal Shah <komal_shah802003@yahoo.com>
Subject: omap git tree inconsistency
Date: Fri, 7 Apr 2006 13:23:21 -0700 (PDT)
Message-ID: <20060407202321.12537.qmail@web32907.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony,

Our tree seems to not properly merged with the mainline. Simple example
is drivers/mmc/Makefile where ATM91 and SDHCI driver is missing and
same for drivers/mmc/KConfig. It happened to me, as my test topic
branch gets synched regularly from linus tree and omap-git and again
showed lot's of merge conflicts when I pulled from omap-git tree
yesterday, which in theory should not show any conflicts which I had
already resolved while merging from linus tree.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
