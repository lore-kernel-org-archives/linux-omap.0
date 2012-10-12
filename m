From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] ARM: config: sort select statements alphanumerically
Date: Fri, 12 Oct 2012 10:08:32 -0400
Message-ID: <20121012140832.GO12330@titan.lakedaemon.net>
References: <20121012132553.GK28061@n2100.arm.linux.org.uk>
 <E1TMfFr-0001Kt-W5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1TMfFr-0001Kt-W5@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Sekhar Nori <nsekhar@ti.com>, Daniel Walker <dwalker@fifo99.com>, Kevin Hilman <khilman@ti.com>, linux-samsung-soc@vger.kernel.org, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, David Brown <davidb@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alessandro Rubini <rubini@unipv.it>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org, spear-devel@list.st.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Kukjin Kim <kgene.kim@samsung.com>, Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, davinci-linux-op
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 12, 2012 at 02:26:19PM +0100, Russell King wrote:
> As suggested by Andrew Morton:
> 
>   This is a pet peeve of mine.  Any time there's a long list of items
>   (header file inclusions, kconfig entries, array initalisers, etc) and
>   someone wants to add a new item, they *always* go and stick it at the
>   end of the list.
> 
>   Guys, don't do this.  Either put the new item into a randomly-chosen
>   position or, probably better, alphanumerically sort the list.
> 
> lets sort all our select statements alphanumerically.  This commit was
> created by the following perl:
> 
> while (<>) {
>         while (/\\\s*$/) {
>                 $_ .= <>;
>         }
>         undef %selects if /^\s*config\s+/;
>         if (/^\s+select\s+(\w+).*/) {
>                 if (defined($selects{$1})) {
>                         if ($selects{$1} eq $_) {
>                                 print STDERR "Warning: removing duplicated $1 entry\n";
>                         } else {
>                                 print STDERR "Error: $1 differently selected\n".
>                                         "\tOld: $selects{$1}\n".
>                                         "\tNew: $_\n";
>                                 exit 1;
>                         }
>                 }
>                 $selects{$1} = $_;
>                 next;
>         }
>         if (%selects and (/^\s*$/ or /^\s+help/)) {
>                 foreach $k (sort (keys %selects)) {
>                         print "$selects{$k}";
>                 }
>                 undef %selects;
>         }
>         print;
> }
> if (%selects) {
>         foreach $k (sort (keys %selects)) {
>                 print "$selects{$k}";
>         }
> }
> 
> It found two duplicates:
> 
> Warning: removing duplicated S5P_SETUP_MIPIPHY entry
> Warning: removing duplicated HARDIRQS_SW_RESEND entry
> 
> and they are identical duplicates, hence the shrinkage in the diffstat
> of two lines.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

For ARCH_DOVE, ARCH_KIRKWOOD, ARCH_MV78XX0, ARCH_ORION5X, PLAT_ORION,
and PLAT_ORION_LEGACY:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
