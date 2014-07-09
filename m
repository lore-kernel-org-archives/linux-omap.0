From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [Re-send PATCH 1/1] arm: dra7xx: Add hwmod data for MDIO and CPSW
Date: Wed, 9 Jul 2014 12:01:47 +0200
Message-ID: <20140709100147.GB25154@breakpoint.cc>
References: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com>
 <20140709095552.GA25154@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140709095552.GA25154@breakpoint.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 2014-07-09 11:55:52 [+0200], Sebastian Andrzej Siewior wrote:
> On 2014-07-08 18:46:39 [+0530], Mugunthan V N wrote:
> > Adding hwmod data for CPSW and MDIO which is present in DRA7xx SoC
>=20
> I reverted my patch, applied this one and after boot I got:
Oh me dum dum. I had --dry-run=E2=80=A6

Acked-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

This is basically what Tony hasked me to do: No IRQ numbers & iomem.

Sebastian
