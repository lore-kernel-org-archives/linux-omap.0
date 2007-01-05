From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Pending December (January) patches
Date: Fri, 05 Jan 2007 16:33:56 +0100
Message-ID: <459E6FE4.5030208@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I had some problems with mail to the list, so instead of a 
pending december patches mail an update which includes 
already our patches from yesterday. Yes, it's clear that 
they can't be applied yet ;)

December 2006 pending patches
-----------------------------

1. [RFC][PATCH] Update MMC response types
http://linux.omap.com/pipermail/linux-omap-open-source/2006-December/008643.html

Note: Is this already merged anywhere else? Or should this 
be applied against OMAP git?


Open, do not apply yet (see list archive for details)
-----------------------------------------------------

1. [PATCH] ARM: OMAP: PalmZ71 MPUIO monitoring
http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008373.html

- Does not apply cleanly, please update

2. [PATCH] ARM: OMAP: omap-alsa-aic23.c cleanup. No code change
http://linux.omap.com/pipermail/linux-omap-open-source/2006-December/008572.html

- Does not apply cleanly, please update

-> Note: Will we get updates for these, or should I remove 
them from my list?


  Pending OMAP patches January 2007
---------------------------------

1. [PATCH] ARM: OMAP: Fix missing workqueue include in 
board-h2.c
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008757.html

2. [PATCH] ARM: OMAP: Update omap_h2_1610_defconfig
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008760.html

3. [PATCH] ARM: OMAP: Workqueue changes for board-h4.c
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008761.html

4. [PATCH] ARM: OMAP: Add missing includes to board-nokia770
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008762.html

5. [PATCH] ARM: OMAP: Add missing include to dsp/mblog.c
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008763.html

6. [PATCH] ARM: OMAP: Workqueue changes for tahvo-usb
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008764.html

7. [PATCH] ARM: OMAP: Workqueue changes for retu-rtc
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008765.html

8. [PATCH] ARM: OMAP: Fix section mismatch warnings in omap-rng
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008769.html

9. [PATCH] ARM: OMAP: Make board-palmz71 compile again
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008770.html

10. [PATCH] ARM: OMAP: Fix warnings in lcd_palmz71
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008771.html

11. innovator_ps2 broken
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008772.html

12. [PATCH] Make omap-ir build with workqueue changes.
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008773.html

13. [PATCH] Make omap_bl build again after API change.
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008776.html

As ususal, correct if anything is wrong or missing, 
especially from december or older. Thanks to Tony for 
merging all of our patches!

Dirk
