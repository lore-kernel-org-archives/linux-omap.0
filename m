From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v4 16/23] ARM: OMAP2+: clock data: Merge utmi_px_gfclk
 into usb_host_hs_utmi_px_clk
Date: Mon, 17 Dec 2012 09:13:06 +0100
Message-ID: <50CED412.7060407@ti.com>
References: <1355134833-5199-1-git-send-email-rogerq@ti.com> <1355134833-5199-17-git-send-email-rogerq@ti.com> <20121214182855.GB4989@atomide.com> <alpine.DEB.2.00.1212141838130.5915@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1212141838130.5915@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, balbi@ti.com, sameo@linux.intel.com, keshava_mgowda@ti.com, sshtylyov@mvista.com, bjorn@mork.no, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Mike Turquette <mturquette@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 12/14/2012 07:44 PM, Paul Walmsley wrote:
> Hi
>=20
> On Fri, 14 Dec 2012, Tony Lindgren wrote:
>=20
>> Paul, what about this patch? Looks like you've acked the other clock=
=20
>> patches in this series but not this one?
>=20
> I commented on it briefly here:
>=20
> https://patchwork.kernel.org/patch/1838111/
>=20
> Maybe Beno=EEt could comment here, but it looks to me (based on a=20
> superficial look at the hardware clock tree data) that these clock no=
des=20
> should exist.  In an ideal world, we'd be able to get back to the=20
> autogeneration of this clock data.

I'm not sure to understand either the rational for that patch. What the
point of merging the two nodes?
I mean, we can do it, but AFAIR, we have always decided to use atomic
node instead of big nodes that handle everything.

Regards,
Benoit
