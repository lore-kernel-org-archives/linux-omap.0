From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Fix ethernet IRQF_TRIGGER flag for apollon
Date: Thu, 21 Dec 2006 16:24:49 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5091AEA5B@dlee02.ent.ti.com>
References: <20061221215755.GE10399@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20061221215755.GE10399@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>=20
> AFAIK we _should_ be able to use level GPIO interrupts on all omap2
> systems. I wonder why that does not work on apollon? Is there some
> difference in hardware, or maybe some GPIO lines don't support level
> interrupts on omap2?

The OMAP GPIOs can trigger on edges or levels.

That seems likely a board level issue.  The Ethernet interrupt from the
raw SMC chip is level assertive.  Depending on the SMC bus hook up mode
its either active high or low through a smc-push-pull output buffer.

On the TI-SDP platforms this signal goes into an FPGA which depending on
the SDP may or may not invert the signal.  It seems over time depending
on the SDP a pull-up may have been necessary on the FPGA to OMAP-GPIO
side when hooked to an open drain fpga output.

At any rate omap-gpios should be ok.  The issue is likely with the smc
to omap path at the board level.

Regards,
Richard W.
