From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 0/5] Updated driver model and various fixes
Date: Mon, 28 Nov 2005 08:54:13 -0800 (PST)
Message-ID: <20051128165413.40259.qmail@web32909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Tony,

Here is a set of patches of updating various driver to use struct
platform_driver, as per the recent patch by Russell King.

In the next round you will find updated driver model for
o rtc (one patch pending)
o ts (dirk's patch pending)
o omap-nand-flash (adding driver model)
o audio
o camera (sensor patch pending)

So, once the pending patches are reviewed and pushed, I will send the
patches for them too. I am only able to test few drivers on H4 as I
don't have OMAP2 boards.


---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free. 
http://music.yahoo.com/unlimited/
