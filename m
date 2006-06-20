From: Komal Shah <komal_shah802003@yahoo.com>
Subject: H4 keypad driver with latest kernel
Date: Tue, 20 Jun 2006 08:48:42 -0700 (PDT)
Message-ID: <20060620154842.83619.qmail@web37911.mail.mud.yahoo.com>
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

Tony/Imre,

H4 keypad driver with latest kernel on linux.omap.com and with two top
commits on gpio.c is not working.

o It only detects the first time key press and release events only,
then after it is not detecting gpio interrupts.

I have reverted two top commits on gpio.c and it is working now. I did
this quickly as I am preparing the keypad driver for linux-input
mailing list submission by tomorrow.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
