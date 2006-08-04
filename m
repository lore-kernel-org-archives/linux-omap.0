From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] fix PWL macro names
Date: Fri, 4 Aug 2006 13:37:44 +0300
Message-ID: <20060804103743.GB26416@atomide.com>
References: <fb249edb0606291210v45cd5bb5odf668ebbc98c3813@mail.gmail.com>
	<20060703155952.GE3852@earth.li>
	<fb249edb0607031920x1059bff9u62018712068599a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0607031920x1059bff9u62018712068599a0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060704 05:22]:
> On 03/07/06, Jonathan McDowell <noodles@earth.li> wrote:
> >On Thu, Jun 29, 2006 at 09:10:35PM +0200, andrzej zaborowski wrote:
> >> Remove "16XX" from the names of PWL-related defines as they are valid
> >> for other models as well.
> >
> >Move them out of omap16xx.h as well then? I'm in favour of this change
> >though.
> 
> Ok, patch attached.
> I will do the same for UART3 defines later because they are used for
> IrDA and I got the IrDA driver working on my OMAP311 with minor
> changes (still testing).

Pushing today. Please separate the core omap files and add a
Signed-off-by next time as specified in:

http://www.muru.com/linux/omap/README_OMAP_PATCHES

Tony
