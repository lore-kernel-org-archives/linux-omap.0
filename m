From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] remoteproc: wkup_m3: Add wkup_m3 remote proc driver
Date: Mon, 5 Jan 2015 14:48:02 -0800
Message-ID: <20150105224802.GM4081@atomide.com>
References: <1420228319-41085-1-git-send-email-d-gerlach@ti.com>
 <1420228319-41085-4-git-send-email-d-gerlach@ti.com>
 <20150102200424.GD4920@saruman> <54AAEFA6.3080603@ti.com>
 <20150105202032.GQ19336@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150105202032.GQ19336@saruman>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150105 12:23]:
> On Mon, Jan 05, 2015 at 02:10:14PM -0600, Dave Gerlach wrote:
> > >> +static int wkup_m3_rpm_suspend(struct device *dev)
> > >> +{
> > >> +	return -EBUSY;
> > >> +}
> > > 
> > > looks like this is just coping with omap_device bogosity, no ?
> > >
> > 
> > Yes, without this omap_device shuts down ther wkup_m3 during suspend, which of
> > course prevents the wkup_m3 from finishing suspend process or waking SoC back
> > up. Haven't found a better solution for the problem than this.
> 
> Tony, any better for this ? Do we keep this small hack or find a better
> way ?

Looks OK to me for now, later on we may want to have a flag for
HWMOD_NEVER_IDLE or something similar for wkup_m3_hwmod. But let's
not add more dependencies to this series.

Regards,

Tony
