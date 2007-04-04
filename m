From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: Pending March patches
Date: Wed, 04 Apr 2007 10:20:28 +0300 (EEST)
Message-ID: <20070404.102028.56387043.Hiroshi.DOYU@nokia.com>
References: <460FD29D.7070707@googlemail.com>
	<20070403193046.GA24864@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070403193046.GA24864@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony,

I confirmed that everything is in "master" branch and the other
branches have not been updated yet, which are related to "mmu
fw"/mailbox/dspgw(?).

Though I don't know how to deal with dspgw code, I guess, at least,
"mailbox" and "mmu fw" can be merged into mainline?

Also there's something strange. There's just small part of dsp code in
"omap-drivers", but it's only a few files, they are not enough.

If this is just a queuing matter(sooner or later), or just on the way,
please ignore this e-mail.

Anyway, it is not so critical at this point. Basically I can use
"master" branch as it is.

		Hiroshi DOYU

> > 4. [PATCH 1/2] ARM:OMAP: Integrated blk request queues for 
> > mbox fwk
> > http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009355.html
> 
> Should be applied already in master branch, but probably buried under
> other changes. Hiroshi, can you please verify?
>
> > 5. [PATCH 2/2] ARM: OMAP: Restructuring mailbox blk queues
> > http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009356.html
> 
> Should be applied already, Hiroshi, can you verify?
>
> > 6. [PATCH 1/2] OMAP: DSP: N800: remaining updates for dsp parts
> > http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009359.html
> 
> Should be applied already, Hiroshi, can you verify?
> 
> > 7. [PATCH 2/2] OMAP: MBOX: N800: remaining updates for 
> > mailbox parts
> > http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009358.html
> 
> Should be applied already, Hiroshi, can you verify?


  Hiroshi DOYU
