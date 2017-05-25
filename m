From: Tony Lindgren <tony@atomide.com>
Subject: Re: [CFT] Always enable SMP mode on MP capable CPUs
Date: Thu, 25 May 2017 15:13:33 -0700
Message-ID: <20170525221332.GE10472@atomide.com>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <CAOMZO5Da2R2_t2nU+MdrJiSzvcBQKS4pwYS96r4UyfGc8DtWww@mail.gmail.com>
 <CAOMZO5Dc=i7UdQH=r5RRr_4GmyZZT+rh7BTNV4WbfqKvtVDfsw@mail.gmail.com>
 <20170519171526.GW22219@n2100.armlinux.org.uk>
 <20170524153847.GY10472@atomide.com>
 <20170525144800.GV23750@n2100.armlinux.org.uk>
 <20170525151103.GC10472@atomide.com>
 <20170525180540.GW23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170525180540.GW23750@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: afzal mohammed <afzal.mohd.ma@gmail.com>, linux-omap@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [170525 11:09]:
> On Thu, May 25, 2017 at 08:11:03AM -0700, Tony Lindgren wrote:
> > 
> > OK. That may not work on am437x though as it's UP.
> 
> Maybe this is just too complicated to grasp - in which case just test
> tonight's linux-next on *all* your boards irrespective of the CPU, and
> let me know if there's a regression due to this patch, giving me full
> details of your CPUs (CPU ID numbers, number of CPUs, etc.)  If no one
> reports a regression that doesn't get fixed, I'll merge it during the
> next merge window.

OK so got my am437x-idk back up and running again. I'm kind of
running out of space here..

And as suspected it won't boot with these changes. It's a UP core:

CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt: Machine model: TI AM437x Industrial Development Kit

Regards,

Tony
