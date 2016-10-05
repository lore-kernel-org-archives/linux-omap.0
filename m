From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: dra72-evm-revc: fix correct phy delay
 and impedance settings
Date: Wed, 5 Oct 2016 08:59:14 +0530
Message-ID: <c454c5d8-e5d6-28f4-a02d-3ce0bc05d986@ti.com>
References: <20161004125607.10569-1-mugunthanvnm@ti.com>
 <20161004125607.10569-4-mugunthanvnm@ti.com>
 <a4ef7fc1-73f7-7136-0d60-6ce8a8ff33b9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <a4ef7fc1-73f7-7136-0d60-6ce8a8ff33b9@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>, netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, David Miller <davem@davemloft.net>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 04 October 2016 06:41 PM, Lokesh Vutla wrote:
> 
> On Tuesday 04 October 2016 06:26 PM, Mugunthan V N wrote:
>> > The default impedance settings of the phy is not the optimal
>> > value, due to this the second ethernet is not working. Fix it
>> > with correct values which makes the second ethernet port to work.
>> > 
>> > Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>> > ---
>> >  arch/arm/boot/dts/dra72-evm-revc.dts | 2 ++
>> >  1 file changed, 2 insertions(+)
>> > 
>> > diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
>> > index f9cfd3b..d626cd7 100644
>> > --- a/arch/arm/boot/dts/dra72-evm-revc.dts
>> > +++ b/arch/arm/boot/dts/dra72-evm-revc.dts
>> > @@ -62,6 +62,7 @@
>> >  		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>> >  		ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_NS>;
>> >  		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
>> > +		ti,min-output-imepdance;
> s/imepdance/impedance
> 

Thanks for quick catch. Will fix this in v3.

Regards
Mugunthan V N
