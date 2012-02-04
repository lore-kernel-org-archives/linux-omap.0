From: Paul Walmsley <paul@pwsan.com>
Subject: Re: omap-serial RX DMA polling?
Date: Sat, 4 Feb 2012 09:42:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202040931590.9453@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com>
 <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com>
 <alpine.DEB.2.00.1201230304310.29673@utopia.booyaka.com>
 <CAAL8m4wBuFQYkyFUwNWrUZTBWuQHggy=y3Oi=6DBHNB_rqU9tA@mail.gmail.com>
 <alpine.DEB.2.00.1201231228310.29673@utopia.booyaka.com>
 <CAAL8m4zE6wD67GCeVe9BOBZ=5yrCkrXUUu26y2GAXrdiDD3R8g@mail.gmail.com>
 <alpine.DEB.2.00.1201240010100.29673@utopia.booyaka.com>
 <20120124090021.GQ16726@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1201240210310.29673@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1201240210310.29673@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, govindraj.raja@ti.com, linux-serial@vger.kernel.org, Govindraj <govindraj.ti@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 24 Jan 2012, Paul Walmsley wrote:

> We (meaning the people working on OMAP) also need to figure out here 
> what the OMAP UART RX timeout would theoretically be, since it doesn't 
> appear to be documented.

Correction.  The UART RX timeout is documented in section 17.4.4.1.3.7.1 
"Time-out Counter" of the 34xx TRM vZT.  The counter starts when the RX 
line is high, sampled in the middle of the bit, and continues for "4x 
programmed word length + 12 bits".  So at 115200 8n1 this looks like
382 microseconds, counted from the center of the stop bit.

Since a wakeup for this event isn't delivered when the UART is in a 
low-power idle state, we should probably consider keeping the UART out of 
idle in the RX path until we get a RX timeout interrupt.  This interrupt 
is only delivered when the RX FIFO has data in it, so we'd have to avoid 
draining the RX FIFO completely if we wanted to use this.


- Paul
