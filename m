From: Matthew Percival <matthew@capgo.com>
Subject: Re: How to recover flash
Date: Tue, 30 May 2006 09:17:44 +1000
Message-ID: <1148944664.8972.4.camel@localhost.localdomain>
References: <ae36f8040605291351p1eb1defar80b2898f7a220125@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040605291351p1eb1defar80b2898f7a220125@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

> Please I destroyed the flash of my OMAP OSK5912 (dev kit) how to recover the
> flash ??
> after download the u-boot latest version i must do saveenv before reboot ?

	The fastest way to recover u-boot on an OSK is to use one of the three
flash recovery utilities:
	Flash Recovery Utility works on Windows, is free, and recovers revision
C boards.
	OMAP Flash Loader works on Unix, is also free, and recovers revision D
boards (both of these can be found at
http://tree.celinuxforum.org/CelfPubWiki/FlashRecoveryUtility).
	The new OMAP Flash Recovery Utility, which still works on Windows, is
now licensed (available for a small fee), and recovers both revision C
and D boards (it can be found at
http://www.softwaredesignsolutions.com/).

	You only need to use saveenv if you have changed a u-boot environmental
variable and wish to maintain that new setting after a reboot: it is not
necessary for simply installing u-boot itself.

	-- Matthew
