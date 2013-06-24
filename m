From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v7 1/9] drivers: phy: add generic PHY framework
Date: Mon, 24 Jun 2013 12:07:18 +0530
Message-ID: <51C7E91E.3030303@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com> <1371113039-5784-2-git-send-email-kishon@ti.com> <51C0CFAC.9080606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <51C0CFAC.9080606@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: grant.likely@linaro.org, tony@atomide.com, balbi@ti.com, arnd@arndb.de, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, linux@arm.linux.org.uk, benoit.cousson@linaro.org, mchehab@redhat.com, cesarb@cesarb.net, davem@davemloft.net, rnayak@ti.com, shawn.guo@linaro.org, santosh.shilimkar@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 19 June 2013 02:52 AM, Sylwester Nawrocki wrote:
> Hi Kishon,
>
> I've noticed there is a little inconsistency between the code and documentation.
>
> On 06/13/2013 10:43 AM, Kishon Vijay Abraham I wrote:
>> +3. Creating the PHY
>> +
>> +The PHY driver should create the PHY in order for other peripheral controllers
>> +to make use of it. The PHY framework provides 2 APIs to create the PHY.
>> +
>> +struct phy *phy_create(struct device *dev, int id, const struct phy_ops *ops,
>> +    void *priv);
>> +struct phy *devm_phy_create(struct device *dev, int id,
>> +    const struct phy_ops *ops, void *priv);
>
> The 'label' argument is missing in those function prototypes. It seems the
> labels must be unique, I guess this needs to be documented. And do we allow
> NULL labels ? If so, then there is probably a check for NULL label needed
> in phy_lookup() and if not, then phy_create() should fail when NULL label
> is passed ?

Yeah. Label is used only for non-dt case so NULL should be allowed while 
phy_create().

Thanks
Kishon
