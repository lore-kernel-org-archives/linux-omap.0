From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V3 7/7] ARM: DRA: Enable Crossbar IP support for DRA7XX
Date: Wed, 13 Nov 2013 11:04:46 -0500
Message-ID: <5283A31E.4070302@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com>
 <1383657257-3458-8-git-send-email-r.sricharan@ti.com>
 <5281BF70.4050708@ti.com> <5281C0E9.8020104@ti.com> <52839B9C.8090707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52839B9C.8090707@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-doc@vger.kernel.org, tony@atomide.com, linus.walleij@linaro.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, Sricharan R <r.sricharan@ti.com>, galak@codeaurora.org, marc.zyngier@arm.com, tglx@linutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@linaro.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 13 November 2013 10:32 AM, Nishanth Menon wrote:
> On 11/11/2013 11:47 PM, Sricharan R wrote:
[..]

> 
> Rationale - with more TI SoCs trending towards crossbar, we dont need
> to keep adding to the soc_is checks, further, we intend to remove
> soc_is checks in it's entirety..
> 
Just for record, and thats what am pushing the TI hardware folks is not to
build default IRQ configuration considering the software will clean-up the
mess. So hope is that we don't have to use this infrastructure always but
only for exceptional cases.

Regards,
Santosh
