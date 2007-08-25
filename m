From: David Brownell <david-b@pacbell.net>
Subject: Re: musb problems in git
Date: Sat, 25 Aug 2007 14:45:05 -0700
Message-ID: <200708251445.05554.david-b@pacbell.net>
References: <0474A5584072DA1197F50007E90E6B1106C7E283@PORTIA>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <0474A5584072DA1197F50007E90E6B1106C7E283@PORTIA>
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
Cc: Albert Santoni <ASantoni@evertz.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 23 August 2007, Albert Santoni wrote:
> Hi guys,
> 
> I pulled the latest musb changes from the OMAP tree into my local DaVinci
> tree, and I'm experiencing a strange problem with the musb_hdrc driver now.

It passed peripheral sanity tests though, at least for me,
hooked up as a high speed link ...


> If I do a certain USB control transfer (that used to work before), dmesg
> will spit out a bunch of these messages:
>     
>     ep0_txstate 495: odd; csr0 0000
> 
> ... and the transfer will timeout. Any further communication from the host
> to the gadget will also timeout.

It's not supposed to do that, obviously.  But without information
about that control transfer, it's hard to say what's going wrong.

That could happen after a MUSB_CSR0_TXPKTRDY irq when there's no
transfer pending but the endpoint is still marked as being in the
TX stage (issuing IN packets) not STATUSOUT (host acks it).


> Upon trying to reload the musb_hdrc module, 
> insmod will freeze.

Again, without info debugging isn't possible.  Where does it
freeze?  Alt-Sysrq-T (or "echo t > /proc/sysrq-trigger") will
show relevant information.


> Lastly, the kernel also occasionally spits out these message:
> 
>     musb_g_ep0_irq 701: SETUP packet len 10 != 8 ?
> 
> I don't recall these messages occuring before I started using the updated
> musb driver. (The last time I saw messages like this was when I had a flakey
> USB cable, but I haven't changed my hardware configuration.)

Those messages seem to be symptoms of some race inside the
hardware.  Usually the value is zero; a couple times I've
seen four; never have I seen ten.  It would be nice to know
how to avoid triggering that race, but if that information
is available it's not in public docs.


> Has anyone else experienced any problems running the latest musb code that's
> in the OMAP tree on a DaVinci kernel?

I ran some host side sanity tests, and yes there are a
few "new" misbehaviors.  The one most relevant to this
would be that the "get interface status" control requests
misbehave, causing regression test failures.  But host and
peripheral roles don't share any protocol code, just the
core I/O logic.

- Dave
