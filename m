From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-bone*: usb0 is hardwired for peripheral
Date: Tue, 24 Feb 2015 10:03:10 -0800
Message-ID: <20150224180309.GH11056@atomide.com>
References: <1424794243-23394-1-git-send-email-robertcnelson@gmail.com>
 <20150224161941.GM29829@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150224161941.GM29829@saruman.tx.rr.com>
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
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150224 08:23]:
> On Tue, Feb 24, 2015 at 10:10:43AM -0600, Robert Nelson wrote:
> > Fixes: http://bugs.elinux.org/issues/127
> > 
> > the bb.org community was seeing random reboots before this change.
> > 
> > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> 
> that's a dead giveaway considering the connector in the board :-)
> 
> Thanks
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>

Applying into omap-for-v4.0/fixes thanks.

Tony
