From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: OMAP5912 OSK & GPIO
Date: Wed, 24 May 2006 16:46:50 +0100
Message-ID: <009d01c67f49$47f84170$642aa8c0@Buffy>
References: <20060523170002.3B4B88062C@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060523170002.3B4B88062C@linux.omap.com>
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

Hi,

Does anybody have any examples for configuring and using the GPIO pins?
I'm trying to toggle GPIO7. I set the data direction bit to output and set
the output pin register bit to high. I have not changed the default pin
muxing, so I assume I should be getting a signal on pin L15, which according
to my schematics is pin 25 on connector P12. I put a scope on there and
don't see anything ;-(

Am I missing some vital part of the puzzle?

Thanks,

Richard.
