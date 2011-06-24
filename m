From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 23/25] ARM: pm: omap34xx: convert to generic
	suspend/resume support
Date: Fri, 24 Jun 2011 08:42:26 +0100
Message-ID: <20110624074226.GI9449@n2100.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk> <E1QZpOS-0005nt-Fq@rmk-PC.arm.linux.org.uk> <BANLkTim2ZL8vV9TUofCdq5F=pbFheHQ=Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTim2ZL8vV9TUofCdq5F=pbFheHQ=Mg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 24, 2011 at 09:37:03AM +0200, Jean Pihet wrote:
> Russell,
>=20
> Just a minor remark:
> On Thu, Jun 23, 2011 at 9:16 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Convert sa11x0 to use the generic CPU suspend/resume support, rathe=
r
>                ^^^^^^^ should be 'OMAP3'
> > than implementing its own version. =A0Tested on 3430 LDP.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks, fixed.
