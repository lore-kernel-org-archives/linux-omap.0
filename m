From: Tony Lindgren <tony@atomide.com>
Subject: Re: Extcon build failure in next
Date: Thu, 30 Jun 2016 05:23:59 -0700
Message-ID: <20160630122359.GP28140@atomide.com>
References: <20160630053705.GM28140@atomide.com> <3746939.q8kt0ym6m3@wuerfel>
 <20160630114911.GO28140@atomide.com> <124460021.HZdfr0AOY2@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <124460021.HZdfr0AOY2@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [160630 05:05]:
> On Thursday, June 30, 2016 4:49:12 AM CEST Tony Lindgren wrote:
> > > > Also I'm seeing:
> > > > 
> > > > drivers/extcon/extcon.c: In function 'extcon_register_notifier':
> > > > drivers/extcon/extcon.c:455:6: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > > >    if (idx >= 0) {
> > > >          ^
> > > 
> > > I don't see this one. Which compiler version do you use?
> > 
> > Looks like I'm currently using older arm-none-linux-gnueabi-gcc
> > (Sourcery CodeBench Lite 2014.05-29) 4.8.3 20140320 (prerelease).
> > I think the Debian compiler was not working few months ago and
> > I changed to something I had around.
> > 
> > Looks like the warning does not appear with arm-linux-gnueabihf-gcc
> > (Debian 6.1.1-3) 6.1.1 20160511.
> 
> You are certainly not the only one using gcc-4.7 or gcc-4.8, but
> they are known to produce more false postive -Wmaybe-uninitialized
> warnings and 4.9 or higher. I usually send patches for these warnings
> when gcc-6 finds them, and I have recently sent patches for all
> the warnings I got in allmodconfig with 4.9, but have no plans to
> do that for the older compilers.

OK thanks for the information, I'll change back to something newer
here again.

> I wonder whether we should just disable this warning with gcc-4.8
> by adding $(call cc-ifversion, -eq, 0408, -Wno-maybe-uninitialized)
> to the command line. However, gcc-4.7 does not let you turn off
> the warning at all, so the use of that is fairly limited.

That probably disables warnings also for real warnings too then :)

Tony
