From: "xuxian" <lsfdxuxian@gmail.com>
Subject: RE: how to burn u-boot into flash
Date: Thu, 11 May 2006 22:24:48 +0800
Message-ID: <4463493f.4b8848f8.630e.ffff9e56@mx.gmail.com>
References: <1147312516.11957.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1147312516.11957.7.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Matthew Percival' <matthew@capgo.com>, 'Linux OMAP Open Source' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello Mattew,

	I have tried the third one and it tells me the u-boot.bin is not a
hex format file. The only thing different is my FlashBurn DSK is a free one.
Are you sure the non-free one can load u-boot.bin? I will consider buying
one.

Best Regards
xuxian

-----Original Message-----
From: linux-omap-open-source-bounces+lsfdxuxian=gmail.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+lsfdxuxian=gmail.com@linux.omap.com]
On Behalf Of Matthew Percival
Sent: Thursday, May 11, 2006 9:55 AM
To: Linux OMAP Open Source
Subject: Re: how to burn u-boot into flash

	G'Day,

	For putting u-boot onto flash, I find the easiest way is to use a
Flash
Recovery Utility: you just plug your board to your computer via USB, and
away it goes.  There are three options:

	The first one:
http://tree.celinuxforum.org/CelfPubWiki/FlashRecoveryUtility
Was the original.  It runs on Windows, but only handles revision C OSKs.

	The second (found at the bottom of the same page) was written for
Linux
users, however, it only handles revision D OSKs.

	The third option:
http://www.softwaredesignsolutions.com/
Is an updated version of the original, which handles both revision C and
D boards.  It runs on Windows, but you have to buy a copy of it.

	I have used all three, and had no problems with any of them.  The
third
one seems to be the third you have tried, and with that you simply need
to select the uboot.bin that results from compiling u-boot (or can be
downloaded from a few sites around too): it will load this just fine.

	-- Matthew

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
