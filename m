From: "andrzej zaborowski" <balrog@zabor.org>
Subject: [PATCH] Unmask omap-keypad interrupt on suspend
Date: Fri, 11 Aug 2006 13:28:13 +0200
Message-ID: <fb249edb0608110428g7bedff21s9320f2da5df447dc@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Prevent keyboard interrupt from staying masked when omap-keypad driver
is suspended. Otherwise, when the driver is compiled in, the kernel
won't resume from a sleep state if any key on the keypad was still
pressed during suspending. This is because the driver masks keyboard
interrupt when irq is received and doesn't unmask it until after keys
are released.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
