From: mirmit <mirmit@bouillot.org>
Subject: Keypad on H4
Date: Fri, 20 Apr 2007 11:31:40 +0200
Message-ID: <986017390704200231ta355cb3we1c7772ae4e9fd28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

I compiled linux kernel 2.6.21-rc7 for Omap2420 H4. I added busybox 1.5.0.
The system boot up correctly. I have a full console/shell on TTYS0. I added
a tty7 with "mknod tty7 c 4 1", added a new shell entry in the inittab with
askfirst.

I have the starting console prompt displayed on the lcd, and if I press the
top left button on the keypad, I have the shell prompt.

However, none of latter keypress are reflected in this console. Even the top
left key which seem to be mapped to the return (\n) key doesn't seem to have
any effect.

Has anybody have a clue?

I the PS2 type keyboard already supported on this board?

Thanks

Mirmit
