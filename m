From: Matthew Percival <matthew@capgo.com>
Subject: Re: how to burn u-boot into flash
Date: Thu, 11 May 2006 11:55:15 +1000
Message-ID: <1147312516.11957.7.camel@localhost.localdomain>
References: <446090f2.2066db8a.3359.56fe@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <446090f2.2066db8a.3359.56fe@mx.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

	G'Day,

	For putting u-boot onto flash, I find the easiest way is to use a Flash
Recovery Utility: you just plug your board to your computer via USB, and
away it goes.  There are three options:

	The first one:
http://tree.celinuxforum.org/CelfPubWiki/FlashRecoveryUtility
Was the original.  It runs on Windows, but only handles revision C OSKs.

	The second (found at the bottom of the same page) was written for Linux
users, however, it only handles revision D OSKs.

	The third option:
http://www.softwaredesignsolutions.com/
Is an updated version of the original, which handles both revision C and
D boards.  It runs on Windows, but you have to buy a copy of it.

	I have used all three, and had no problems with any of them.  The third
one seems to be the third you have tried, and with that you simply need
to select the uboot.bin that results from compiling u-boot (or can be
downloaded from a few sites around too): it will load this just fine.

	-- Matthew
