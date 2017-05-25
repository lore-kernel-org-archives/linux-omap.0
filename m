From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [CFT] Always enable SMP mode on MP capable CPUs
Date: Thu, 25 May 2017 15:48:00 +0100
Message-ID: <20170525144800.GV23750@n2100.armlinux.org.uk>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <CAOMZO5Da2R2_t2nU+MdrJiSzvcBQKS4pwYS96r4UyfGc8DtWww@mail.gmail.com>
 <CAOMZO5Dc=i7UdQH=r5RRr_4GmyZZT+rh7BTNV4WbfqKvtVDfsw@mail.gmail.com>
 <20170519171526.GW22219@n2100.armlinux.org.uk>
 <20170524153847.GY10472@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170524153847.GY10472@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 24, 2017 at 08:38:47AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [170519 10:19]:
> > We could expand the table to positively identify the SMP capable CPUs
> > and enable the SMP bit there, but it's going to add a lot of entries
> > there (one for each specific ARMv7 MP CPU) and is going to have to be
> > endlessly added to each time a new SMP CPU comes out.
> 
> Looks like commit e414690faa81 ("ARM: always enable SMP mode on SMP cores")
> causes booting to fail early at least on omap4430 duovero. It's a bit of
> a mystery as it is SMP.. And pandboard es (4460) and droid 4 (4430) work
> without the conditional write..
> 
> Partial revert like below seems to make it boot again.

Thanks for testing, I'll integrate your change, and it should be in
tonight's linux-next.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
