From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/8] ARM: OMAP2+: Allow core oswr for omap4
Date: Wed, 16 Oct 2019 07:46:42 -0700
Message-ID: <20191016144642.GD5610@atomide.com>
References: <20191010001224.41826-1-tony@atomide.com>
 <20191010001224.41826-8-tony@atomide.com>
 <20191013150806.GE13278@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191013150806.GE13278@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Merlijn Wajer <merlijn@wizzup.org>, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [191013 15:08]:
> On Wed 2019-10-09 17:12:23, Tony Lindgren wrote:
> > Commit f74297dd9354 ("ARM: OMAP2+: Make sure LOGICRETSTATE bits are not
> > cleared") disabled oswr (open switch retention) for per and core domains
> > as various GPIO related issues were noticed if the bootloader had
> > configured the bits for LOGICRETSTATE for per and core domains.
> > 
> > With the recent gpio-omap fixes, mostly related to commit e6818d29ea15
> > ("gpio: gpio-omap: configure edge detection for level IRQs for idle
> > wakeup"), things now behave for enabling core oswr for omap4.
> > 
> > Cc: Merlijn Wajer <merlijn@wizzup.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> 2,7,8 basically modify same lines of code? Should that be done in one
> patch?

In this case let's change one thing at a time as many issues
have been seen earlier with these settings. We want git bisect
to tell us which change breaks things in case of trouble.

The related gpio related issues should be fixed now though.

Regards,

Tony
