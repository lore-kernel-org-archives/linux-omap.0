From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Git tree updated to 2.6.23-rc2
Date: Thu, 09 Aug 2007 20:34:56 -0700
Message-ID: <46BBDCE0.4000303@mvista.com>
References: <20070806125225.GA2312@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070806125225.GA2312@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> Hi all,
> 
> I've just updated our git tree to 2.6.23-rc2. Thanks to Trilok, now
> the omap framebuffer code is integrated to the mainline kernel :)
> 
> There are quite a few pending patches, I will be looking at them
> this week.

Anyone else running a VFP userland on 24xx?

Starting with this latest merge, I'm started seeing a bunch of VFP
errors as soon as userland starts (see below.)  The errors continue to
spew and I eventually get a console, but any command just triggers them
again.


[...]
Looking up port of RPC 100005/3 on 192.168.1.2

VFS: Mounted root (nfs filesystem).

Freeing init memory: 124K

VFP: instr ecac8b11 pc 40016368 state c04a21b0

VFP: fpexc 00000000

VFP: enable c04a21b0

VFP: save old state 00000000

VFP: load state c04a21b0

VFP: instr ecac8b11 pc 40016368 state c04a21b0

VFP: fpexc 00000000

VFP: enable c04a21b0

VFP: instr ecac8b11 pc 40016368 state c04a21b0

VFP: fpexc 00000000

VFP: enable c04a21b0

VFP: instr ecac8b11 pc 40016368 state c04a21b0

VFP: fpexc 00000000

VFP: enable c04a21b0

VFP: instr ecac8b11 pc 40016368 state c04a21b0

VFP: fpexc 00000000

VFP: enable c04a21b0

[...]
