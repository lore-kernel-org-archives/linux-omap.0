From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 16/23] ARM: OMAP2+: clock data: Merge utmi_px_gfclk
 into usb_host_hs_utmi_px_clk
Date: Mon, 17 Dec 2012 18:13:19 +0200
Message-ID: <50CF449F.7090708@ti.com>
References: <1355134833-5199-1-git-send-email-rogerq@ti.com> <1355134833-5199-17-git-send-email-rogerq@ti.com> <20121214182855.GB4989@atomide.com> <alpine.DEB.2.00.1212141838130.5915@utopia.booyaka.com> <50CED412.7060407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50CED412.7060407@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, balbi@ti.com, sameo@linux.intel.com, keshava_mgowda@ti.com, sshtylyov@mvista.com, bjorn@mork.no, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Mike Turquette <mturquette@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 12/17/2012 10:13 AM, Benoit Cousson wrote:
> Hi,
>=20
> On 12/14/2012 07:44 PM, Paul Walmsley wrote:
>> Hi
>>
>> On Fri, 14 Dec 2012, Tony Lindgren wrote:
>>
>>> Paul, what about this patch? Looks like you've acked the other cloc=
k=20
>>> patches in this series but not this one?
>>
>> I commented on it briefly here:
>>
>> https://patchwork.kernel.org/patch/1838111/
>>
>> Maybe Beno=EEt could comment here, but it looks to me (based on a=20
>> superficial look at the hardware clock tree data) that these clock n=
odes=20
>> should exist.  In an ideal world, we'd be able to get back to the=20
>> autogeneration of this clock data.
>=20
> I'm not sure to understand either the rational for that patch. What t=
he
> point of merging the two nodes?
> I mean, we can do it, but AFAIR, we have always decided to use atomic
> node instead of big nodes that handle everything.
>

I can see a similar thing done for mcbsp clocks (e.g. /* Merged
func_mcbsp1_gfclk into mcbsp1 */), mmc clocks, timer clocks, mcasp
clock, and sgx clock. i.e. The clock sel (mux) is combined with clock
gate. I don't see why USB host has to be done differently.

Were exceptions made for the above clocks in the auto generation code?

The problem from driver point of view is that it has to manage an
additional clock per port. Not a big deal, but I thought it could be
avoided.

regards,
-roger
