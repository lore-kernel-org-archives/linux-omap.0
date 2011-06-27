From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 00/18] I2C: OMAP: I2C fixes, removal of cpu_is...
	from driver
Date: Mon, 27 Jun 2011 15:15:18 -0700
Message-ID: <1309212918.6231.16.camel@vence>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
	<20110615213637.GH15795@trinity.fluff.org>  <87k4cm1xgj.fsf@ti.com>
	<1309212726.6231.14.camel@vence>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1309212726.6231.14.camel@vence>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben-i2c@fluff.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 2011-06-27 at 15:12 -0700, Kevin Hilman wrote:

> Ping.  I don't see this in linux-next yet.
> 
> Are you planning to queue this for v3.1?
> 

Oops, pushed send too soon on this...

As this series touches various data files in arch/arm/mach-omap2/* and
we have a handful of other changes to that data for this merge window, I
think it would be better for conflict avoidance if this series is merged
via Tony's linux-omap tree.

With your Ack, we'll merge it via OMAP.

Thanks,

Kevin
