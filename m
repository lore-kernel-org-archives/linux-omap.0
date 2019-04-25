From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH v3 net-next 01/11] net: ethernet: ti: cpts: use
 devm_get_clk_from_child
Date: Thu, 25 Apr 2019 13:05:09 +0300
Message-ID: <3aae7697-3b7f-492b-0600-b6d1382511c3@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-2-git-send-email-grygorii.strashko@ti.com>
 <20190424224607.GB23779@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424224607.GB23779@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>
List-Id: linux-omap@vger.kernel.org



On 25.04.19 01:46, Andrew Lunn wrote:
> On Thu, Apr 25, 2019 at 01:24:17AM +0300, Grygorii Strashko wrote:
>> Use devm_get_clk_from_child() instead of devm_clk_get() and this way allow
>> to group CPTS DT properties in sub-node for better code readability and
>> maintenance.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>  drivers/net/ethernet/ti/cpts.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
>> index 499806ce4cd5..aad118e71b61 100644
>> --- a/drivers/net/ethernet/ti/cpts.c
>> +++ b/drivers/net/ethernet/ti/cpts.c
>> @@ -572,7 +572,7 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
>>  	if (ret)
>>  		return ERR_PTR(ret);
>>  
>> -	cpts->refclk = devm_clk_get(dev, "cpts");
>> +	cpts->refclk = devm_get_clk_from_child(dev, node, "cpts");
>>  	if (IS_ERR(cpts->refclk)) {
>>  		dev_err(dev, "Failed to get cpts refclk\n");
>>  		return ERR_CAST(cpts->refclk);
> 
> Hi Grygorii
> 
> Does this break backwards compatibility for existing DT blobs?
> Maybe you need to look in both the old and new locations?

No. It doesn't - default node is cpsw->dev->of_node.

Then Patch 7 changes it fro new driver to 
-	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpsw->dev->of_node);
+	cpts_node = of_get_child_by_name(cpsw->dev->of_node, "cpts");
+	if (!cpts_node)
+		cpts_node = cpsw->dev->of_node;
+
+	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpts_node);

-- 
Best regards,
grygorii
