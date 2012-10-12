From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: config: sort select statements alphanumerically
Date: Fri, 12 Oct 2012 15:48:32 +0100
Message-ID: <20121012144832.GN28061@n2100.arm.linux.org.uk>
References: <20121012132553.GK28061@n2100.arm.linux.org.uk>
 <E1TMfFr-0001Kt-W5@rmk-PC.arm.linux.org.uk>
 <CACRpkdba1q52bEDcWsd47QwXA-DNhq6PENf2M-tvZ6znYu+5yw@mail.gmail.com>
 <20121012144119.GM28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20121012144119.GM28061@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Daniel Walker <dwalker@fifo99.com>, Kevin Hilman <khilman@ti.com>, linux-samsung-soc@vger.kernel.org, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-msm@vger.kernel.org, David Brown <davidb@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alessandro Rubini <rubini@unipv.it>, Stephen Warren <swarren@wwwdotorg.org>, Sekhar Nori <nsekhar@ti.com>, spear-devel@list.st.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Kukjin Kim <kgene.kim@samsung.com>, Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, davinci-linux-ope
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 12, 2012 at 03:41:20PM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 12, 2012 at 04:04:28PM +0200, Linus Walleij wrote:
> > On Fri, Oct 12, 2012 at 3:26 PM, Russell King
> > <rmk+kernel@arm.linux.org.uk> wrote:
> > 
> > > As suggested by Andrew Morton:
> > >
> > >   This is a pet peeve of mine.  Any time there's a long list of items
> > >   (header file inclusions, kconfig entries, array initalisers, etc) and
> > >   someone wants to add a new item, they *always* go and stick it at the
> > >   end of the list.
> > >
> > >   Guys, don't do this.  Either put the new item into a randomly-chosen
> > >   position or, probably better, alphanumerically sort the list.
> > >
> > > lets sort all our select statements alphanumerically.  This commit was
> > > created by the following perl:
> > 
> > I applied this and tried to configure the Nomadik defconfig,
> > and I get this, sadly:
> 
> Yes, I've just fixed those.  Unfortunately, the patch is soo large that
> it trips the mailing list size limit, and has to be manually approved,
> so I'm not sure I can call on the list maintainers again today to do the
> approval thing.

Instead, here's the updated script:

8<===
#!/usr/bin/perl
while (<>) {
	while (/\\\s*$/) {
		$_ .= <>;
	}
	undef %selects if /^\s*config\s+/;
	if (/^\s+select\s+(\w+).*/) {
		if (defined($selects{$1})) {
			if ($selects{$1} eq $_) {
				print STDERR "Warning: removing duplicated $1 entry\n";
			} else {
				print STDERR "Error: $1 differently selected\n".
					"\tOld: $selects{$1}\n".
					"\tNew: $_\n";
				exit 1;
			}
		}
		$selects{$1} = $_;
		next;
	}
	if (%selects and (/^\s*$/ or /^\s+help/ or /^\s+---help---/ or
			  /^endif/ or /^endchoice/)) {
		foreach $k (sort (keys %selects)) {
			print "$selects{$k}";
		}
		undef %selects;
	}
	print;
}
if (%selects) {
	foreach $k (sort (keys %selects)) {
		print "$selects{$k}";
	}
}
8<===

Run it like this (assuming its saved as sort.pl):

for f in $(find arch/arm -name 'Kconfig*'); do perl sort.pl $f > $f.new \
	&& mv $f.new $f && git update-index $f; done

Omit the "git update-index" bit if you don't want to commit the result.
("git update-index" is safer than "git add" for this as "git add" will
add new files, "git update-index" won't without an additional option.
That's not a recommendation to use it though.)
