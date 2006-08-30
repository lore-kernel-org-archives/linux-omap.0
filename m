From: Mark Howell <mhowell@northlink.com>
Subject: Re: [PATCH] ARM: OMAP: mux: add config for 16xx SPI pins
Date: Wed, 30 Aug 2006 08:57:18 +0800
Message-ID: <44F4E26E.4050701@northlink.com>
References: <44C7D8AC.7070505@northlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <44C7D8AC.7070505@northlink.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Mark Howell <mhowell@northlink.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Mark Howell wrote:
> This patch adds pin mux info for the SPI master/slave interface on 
> OMAP16xx. Data from OMAP 1611/1612 TRM and errata. Works for me on my
>  1611/H2 with current git kernel.
> 

I have since spent some lab time with a scope and figured out that I
misunderstood the pull-up config bits in the mux definition structure
(they are inverted vs. what is actually written to the pull-up control 
registers). The patch I posted before works, but it can be better.

I'll post a patch to set better default values for 16xx SPI pin mux
after I get a little more lab time. I don't think this is a burning
issue for anyone 'cept me, since eons had passed without anyone spec'ing
these pins for 16xx SPI anyway :-)

But this brings up a question... there are some other pins where I'm
suspicious of the default pull-up config in mux.c, such as for the
u-wire interface. Won't there be a bit of a power penalty for turning on
pull-up or pull-down when it isn't necessary? Is there some established 
opinion or practice in this group regarding pin mux pull-up config to 
which I can refer?

Cheers,

Mark.
