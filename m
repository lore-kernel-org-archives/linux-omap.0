From: "Adam Brooks" <adam.j.brooks@gmail.com>
Subject: Re: [PATCH 00/32] Convert ARM to generic irq subsystem
Date: Tue, 2 May 2006 11:18:23 -0700
Message-ID: <7129f14c0605021118l439349dcwab1fa5868baf1eb@mail.gmail.com>
References: <20060407095850.690110000@localhost.localdomain>
	<20060426230543.GA28908@flint.arm.linux.org.uk>
	<44529239.2060409@mvista.com>
	<1146263927.1322.640.camel@localhost.localdomain>
	<4452A282.4050909@mvista.com>
	<1146305308.1322.657.camel@localhost.localdomain>
	<20060502115914.GF24728@atomide.com>
	<1146573190.1322.678.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1146573190.1322.678.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-omap-open-source@linux.omap.com, LAK <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Everything appears to be working on the IOP3xx boards. There is one
thing I would like to confirm.  None of the patches changed anything
in the mach-iop3xx directory.  Was this because no changes were
required, or is our arch not actually using the new mechanism at this
point?

-Adam Brooks

On 5/2/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 2006-05-02 at 04:59 -0700, Tony Lindgren wrote:
> > > Applied and released -rc3-armirq2.
> >
> > Patches seem to work for me too on various omap boards. Also dyntick
> > works.
>
> Thanks for testing.
>
> > Should this part in kernel/irq/handle.c be CONFIG_ARM for now?
>
> Yes, until we find a unified solution for dynamic ticks.
>
>         tglx
>
>
>
>
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kern=
el
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
>

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
