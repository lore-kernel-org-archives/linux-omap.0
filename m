From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
Date: Tue, 10 Dec 2013 12:36:57 -0800
Message-ID: <20131210203657.GU13171@atomide.com>
References: <pull-1386643347-596413>
 <20131210143547.GA32243@n2100.arm.linux.org.uk>
 <20131210160144.GG13171@atomide.com>
 <20131210160703.GB32243@n2100.arm.linux.org.uk>
 <20131210165958.GH13171@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20131210165958.GH13171@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131210 09:01]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [131210 08:08]:
> > 
> > Right, so I should just turn off building OMAP3 for the remainder of this
> > cycle.
> > 
> > What's the fscking point me running a build system, because if I switch
> > it now, OMAP3 breaks.  If I don't switch it now and your pull request is
> > merged, it breaks at that point.
> 
> Fair enough, I hear you.
>  
> > This is utterly insane.
> 
> Well let's do this. Let's merge the parts that add stuff now, then wait
> a week (or longer as needed) so you have both ways working with linux
> next for a while. Does that sounds reasonable to you?

OK I've added a tag to the same branch earlier before we remove any of
the legacy omap3 support and sent a new pull request.

Regards,

Tony
