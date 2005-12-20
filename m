From: Matthew Percival <matthew@capgo.com>
Subject: Re: Re: Regarding McBSP Int ...help needed... (Matthew Percival)
Date: Wed, 21 Dec 2005 09:40:05 +1100
Message-ID: <1135118405.8928.17.camel@localhost.localdomain>
References: <D8595042F3765A4285B848A78A2C2ED101F596EA@bsdmsg002.corp.satyam.ad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <D8595042F3765A4285B848A78A2C2ED101F596EA@bsdmsg002.corp.satyam.ad>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

> There is indeed a bit a advance in the sense, My ISR is executed twice
> now after including ur line of code. But after that no response. 

	I would say that your interrupts are all working fine now (it is
executes twice, it is unlikely that you have any problems there), but I
would be inclined to say that your problem is related to your McBSP
configuration: the interrupt is probably not being asserted a third time
for some reason (you might want to watch the L2.0 handler registers to
confirm this).

	My guess would be that you get the first interrupt, fill the McBSP
buffer, and this buffer is then loaded to be transmitted; now the buffer
is empty, you get the second interrupt and again fill the buffer.  If
the transmission never occurs, however, the buffer will never be emptied
again, therefore the interrupt will not be asserted a third time.  This
is just speculation, but I would suggest first confirming that the
interrupt is indeed asserted a third time, and if not then make sure
that your McBSP is actually transmitting.

	-- Matthew
