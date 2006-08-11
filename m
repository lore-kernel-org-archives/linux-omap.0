From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Unmask omap-keypad interrupt on suspend
Date: Fri, 11 Aug 2006 13:52:32 +0300
Message-ID: <20060811105231.GK6720@atomide.com>
References: <fb249edb0608110343l5277119cu977ba382a455368d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0608110343l5277119cu977ba382a455368d@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060811 13:46]:
> Prevent keyboard interrupt from staying masked when omap-keypad driver
> is suspended. Otherwise, when the driver is compiled in, the kernel
> won't resume from a sleep state if any key on the keypad was still
> pressed during suspending. This is because the driver masks keyboard
> interrupt when irq is received and doesn't unmask it until after keys
> are released.

No Signed-off-by: ? :)

Tony
