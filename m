From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Thu, 30 Nov 2006 16:57:12 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A508CE05B3@dlee02.ent.ti.com>
References: <200611301432.46837.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200611301432.46837.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Not that I have time to look into OMAP2 low power modes ... but I'd
> thought
> the preferred solution when low power was a concern would be to use
the
> 32k timers not the general purpose ones, and that you more or less
said
> just that.  Did I translate that correctly?  :)

Mostly :), but you have more options depending on your target mode.

There is one GPT in the wake up domain and a bunch in the CORE domain.
The all can have source 32K/SYSCK/ALTCK.  All of them are 'wakeup
capable' however, depending on the depth of your sleep the CORE ones may
not wake you.  You can target sleep modes where you can sleep in between
peripheral activity and use the CORE peripheral wake you.  In those
cases interface clocks are auto gated but some functional clocks can
run.  (a timer can do this).  So you can use a CORE timer and still hit
perhaps your most used power mode.  For Retention you (non-functional)
must use a WKUP one.

One sort of nice aspect of using SYSCLK is its value can be more
accurate and its resolution is higher for time stamps.

A 32K timer is really 32768 no 32000 and over timer you accumulate error
faster.  Some users alternate sleep times over an interval to account
for this error.  It is less necessary to do this with a MHz timer, but
perhaps a bit depending on your input speed.

For a 1ms tick target 32*1/32768=3D.976ms and a 33*1/32768=3D1.007ms.  =
You
can fix this by alternating between 32 and 33 over an interval.=20

Regards,
Richard W.
