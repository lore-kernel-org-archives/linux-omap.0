From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 00/18] I2C: OMAP: I2C fixes, removal of cpu_is...
	from driver
Date: Mon, 27 Jun 2011 15:12:06 -0700
Message-ID: <1309212726.6231.14.camel@vence>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
	<20110615213637.GH15795@trinity.fluff.org>  <87k4cm1xgj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87k4cm1xgj.fsf@ti.com>
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

On Wed, 2011-06-15 at 16:33 -0700, Kevin Hilman wrote:
> Hi Ben,
> 
> Ben Dooks <ben-i2c@fluff.org> writes:
> 
> > On Wed, Jun 01, 2011 at 05:19:26PM -0700, Kevin Hilman wrote:
> >> Ben, 
> >> 
> >> Please pull in this series from Andy Green for the next merge window.
> >> 
> >> v4 is simply a rebase of Andy's v3 against v3.0-rc1 with some basic
> >> sanity testing against with the latest kernel.
> >
> > These look much more like functionality changes than actual fixes, and
> > are much more suited for inclusion into -next for once the next stable
> > release is out.
> 
> Correct, this is a rework of functionality, not a set of fixes.  This
> series is targeted for the next release (v3.1), not for fixes
> (v3.0-rc).  
> 
> I was requesting for it to be included in your queue for -next and for
> the next merge window.
> 
> Tony has already been merging this in his omap-testing branch so it is
> has been getting lots of testing on OMAP platforms already.

Ping.  I don't see this in linux-next yet.

Are you planning to queue this for v3.1?

Thanks,

Kevin
