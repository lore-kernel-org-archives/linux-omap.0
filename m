From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 05/11] mfd: omap: control: core system
 control driver
Date: Fri, 1 Jun 2012 04:29:51 -0700
Message-ID: <20120601112951.GM12766@atomide.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-6-git-send-email-eduardo.valentin@ti.com>
	<4FBF8078.9050809@ti.com> <20120528113502.GG3923@besouro>
	<4FC4CE4B.8020708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FC4CE4B.8020708@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, J Keerthy <j-keerthy@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Cousson, Benoit <b-cousson@ti.com> [120529 06:29]:
> On 5/28/2012 1:35 PM, Eduardo Valentin wrote:
> >>
> >>Mmm, we can have up to 4 control module instances in OMAP4.
> >>
> >>Well, I'm not sure it worth considering them as separate devices. Is
> >>that your plan as well?
> >
> >At least for now I was focusing on the ctrl_module_core ...
> 
> OK, that's a good start already :-)
> 
> >>But since they all have different base address, it will be trick to
> >>handle them with only a single entry.
> >
> >Indeed. We can always add the support latter on.
> >
> >I am not sure what would be the best way to handle those instances though,
> >and how they are going to expose APIs. Would need to have an instance bound
> >to API set?
> 
> We should not go to that path I guess. We should have an API at
> children level independent of the underlying control module
> partitioning.

These should be separate driver instances for the control modules.

And then the ioremapped area should ignore at least the padconf
registers so drivers/pinctrl/pinctrl-simple can handle those. There
should not be any dependencies to the SCM driver from pinctrl-simple,
the core SCM driver can manage the clocks and trigger the save of
padconf regs.

Also we should allow MMC driver handle the MMC specific registers
and USB driver(s) handle the USB specific registers if possible. Those
should not live under drivers/mfd unless there are some dependencies
other than trying to ioremap the whole SCM module instead of ioremapping
in each driver.

We can have a static map for the SCM, so ioremapping each driver
individually should not be an issue.

Regards,

Tony
