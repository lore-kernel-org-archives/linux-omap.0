From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v2 2/2] regulator: tps65910: Allow supply references to
 the same chip
Date: Tue, 13 Jun 2017 22:22:17 +0200
Message-ID: <20170613202217.nj23xkahpz3jc4h5@qmqm.qmqm.pl>
References: <f2aee03834d8cdcc7195b9272982617d93f978dc.1497364762.git.mirq-linux@rere.qmqm.pl>
 <053529c206a2afc453b52e2c0f024acd85341a83.1497364762.git.mirq-linux@rere.qmqm.pl>
 <20170613174628.sv4v76s7torrn5jx@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170613174628.sv4v76s7torrn5jx@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, j-keerthy@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 13, 2017 at 06:46:28PM +0100, Mark Brown wrote:
> On Tue, Jun 13, 2017 at 04:41:58PM +0200, Micha³ Miros³aw wrote:
> > This allows for (acyclic) references from tps6591x supplies to
> > its outputs.
> This is clearly not something that should be open coded in individual
> drivers, aside from the code duplication it is obviously possible to
> have two different chips supplying each other which this wouldn't help
> at all.  Is this happening for you with current kernels, we have a few
> mechanisms for deferring bindings of supplies which should help here.

What mechanisms would that be? What I observed is that whenever
a regulator's supply is not available but described in device-tree,
the whole device's registration is deferred.

The device-tree I'm working on contains:

pmic: tps65911@2d { 
    compatible = "ti,tps65911"; 
    reg = <0x2d>; 
    ...
    vcc3-supply = <&vio_reg>; // ldo6, ldo7, ldo8
    ...
    regulators {
        vio_reg: vio {
            regulator-min-microvolt = <1800000>;
            regulator-max-microvolt = <1800000>;
            regulator-always-on;
        };
        ...
    }
}

Best Regards,
Micha³ Miros³aw
