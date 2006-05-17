From: Kevin Hilman <khilman@mvista.com>
Subject: git tags update
Date: Wed, 17 May 2006 12:19:40 -0700
Message-ID: <1147893580.8739.75.camel@vence.internal.net>
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
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Tony,

The OMAP tree was missing tags since 2.6.15-rc1.  I've updated the tags
in the tree as of today's linus tree.

I did:

$ git pull --tags
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

$ git push --tags git://source.mvista.com/git/linux-omap-2.6.git 
