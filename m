From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Subject: Re: [PATCH v4 1/6] drivers: phy: add generic PHY framework
Date: Tue, 02 Apr 2013 00:27:36 +0200
Message-ID: <515A09D8.7040703@gmail.com>
References: <1364449408-9510-1-git-send-email-kishon@ti.com> <1364449408-9510-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1364449408-9510-2-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, arnd@arndb.de, akpm@linux-foundation.org, rob@landley.net, swarren@wwwdotorg.org, davem@davemloft.net, cesarb@cesarb.net, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, b-cousson@ti.com, linux@arm.linux.org.uk, eballetbo@gmail.com, javier@dowhile0.org, mchehab@redhat.com, santosh.shilimkar@ti.com, broonie@opensource.wolfsonmicro.com, swarren@nvidia.com, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/28/2013 06:43 AM, Kishon Vijay Abraham I wrote:
> diff --git a/Documentation/devicetree/bindings/phy/phy-bindings.txt
>b/Documentation/devicetree/bindings/phy/phy-bindings.txt
> new file mode 100644
> index 0000000..35696b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-bindings.txt
> @@ -0,0 +1,76 @@
> +This document explains only the dt data binding. For general information about
> +PHY subsystem refer Documentation/phy.txt
> +
> +PHY device node
> +===============
> +
> +Optional Properties:
> +#phy-cells:	Number of cells in a PHY specifier;  The meaning of all those
> +		cells is defined by the binding for the phy node. However
> +		in-order to return the correct PHY, the PHY susbsystem
> +		requires the first cell always refers to the port.
> +
> +This property is optional because it is needed only for the case where a
> +single IP implements multiple PHYs.
> +
> +For example:
> +
> +phys: phy {
> +    compatible = "xxx";
> +    reg1 =<...>;
> +    reg2 =<...>;
> +    reg3 =<...>;
> +    .
> +    .
> +    #phy-cells =<1>;
> +    .
> +    .
> +};
> +
> +That node describes an IP block that implements 3 different PHYs. In order to
> +differentiate between these 3 PHYs, an additonal specifier should be given
> +while trying to get a reference to it. (The PHY subsystem assumes the
> +specifier is port id).
> +
> +PHY user node
> +=============
> +
> +Required Properties:
> +phys : the phandle for the PHY device (used by the PHY subsystem)
> +
> +Optional properties:
> +phy-names : the names of the PHY corresponding to the PHYs present in the
> +	    *phys* phandle
> +
> +example1:
> +phys: phy {
> +    compatible = "xxx";
> +    reg =<...>;
> +    .
> +    .
> +    phys =<&usb2_phy>,<&usb3_phy>;
> +    phy-names = "usb2phy", "usb3phy";
> +    .
> +    .
> +};
> +This node represents a controller that uses two PHYs one for usb2 and one for
> +usb3. The controller driver can get the appropriate PHY either by using
> +devm_of_phy_get/of_phy_get by passing the correct index or by using
> +of_phy_get_byname/devm_of_phy_get_byname by passing the names given in
> +*phy-names*.
> +
> +example2:
> +phys: phy {
> +    compatible = "xxx";
> +    reg =<...>;
> +    .
> +    .
> +    phys =<&phys 1>;
> +    .
> +    .
> +};
> +
> +This node represents a controller that uses one of the PHYs which is defined
> +previously. Note that the phy handle has an additional specifier "1" to
> +differentiate between the three PHYs. For this case, the controller driver
> +should use of_phy_get_with_args/devm_of_phy_get_with_args.

This means a PHY user needs to know indexes at the PHY driver ?

I have been thinking of using this for an IP which has 4 video PHYs: 2 MIPI
CSI-2 and 2 MIPI DSI. The IP has just 2 registers, each of which is shared
between one MIPI CSI-2 DPHY and one MIPI DSI DPHY. So I thought about 
creating
a single device node for this IP and using 4 indexes for the PHYs, e.g. 
0...3.
Then users of each PHY type would use only indexes 0..1 (to select their
corresponding port).

However I fail to see how this could now be represented in the bindings.

I assume struct phy::type could be used to differentiate between CSI-2 
and DSI.
And struct phy::port could be used to select specific CSI-2 or DSI channel
(0, 1). Ideally the phy users should not care about index of a PHY at 
the PHY
device tree node. E.g. there are 2 MIPI CSI-2 receivers and each has only
one PHY assigned to it. I'm just wondering how the binding should look like,
so a PHY could be associated with a receiver automatically by the phy-core,
e.g.

/* DPHY IP node */
video-phy {
	  reg = <0x10000000 8>;
};

/* MIPI DSI nodes */
dsi_0 {
      phys = <&video-phy 0>;
};

dsi_1 {
      phys = <&video-phy 1>;
};

/* MIPI CSI-2 nodes */
csi_0 {
      phys = <&video-phy 2>;
};

csi_1 {
      phys = <&video-phy 3>;
};

I'm not sure if it is not an overkill to use this the PHY framework with
a device which has only 2 registers. Perhaps something less heavy could
be designed for it. However, if the PHY framework is commonly used there
should be no issue wrt enabling the whole big infrastructure for a simple
device like this.


Thanks,
Sylwester
