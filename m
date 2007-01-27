From: tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP: Fix warnings in musb_procfs.c
Date: Sat, 27 Jan 2007 09:58:21 -0800
Message-ID: <20070127175820.GA18115@atomide.com>
References: <45B1C052.4020809@googlemail.com> <45BAF3CE.7090806@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45BAF3CE.7090806@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070126 22:40]:
> Dirk Behme wrote:
> >ARM: OMAP: Fix warnings in musb_procfs.c:
> 
> What's about this one? Do I overlooked any comments?

Oh yeah, I was hoping Dave would have a chance to look
at the pending usb patches... This one is a no brainer
though :)
 
> It's the last one in my pending patches list ;)
> 
> Orginal post:
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008903.html

See also Felipe's fix for rmmoding musb_hdrc to remove
extra register write after chip is already powered
down:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008853.html

Then there's Kuyngmin's DMA patch for 24xx:

http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008342.html

Regards,

Tony
