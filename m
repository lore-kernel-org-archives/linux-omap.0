From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH linux-next 09/10] dt-bindings: net: ti: deprecate
 cpsw-phy-sel bindings
Date: Tue, 27 Nov 2018 12:29:05 -0600
Message-ID: <06fde096-15cb-e2c9-f1e4-dad43a4e0fca@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
 <20181126001531.12974-10-grygorii.strashko@ti.com>
 <20181126195838.GA19167@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181126195838.GA19167@bogus>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 11/26/18 1:58 PM, Rob Herring wrote:
> On Sun, Nov 25, 2018 at 06:15:30PM -0600, Grygorii Strashko wrote:
>> The cpsw-phy-sel driver was replaced with new PHY driver phy-gmii-sel, so
>> deprecate cpsw-phy-sel bindings.
>>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   Documentation/devicetree/bindings/net/cpsw-phy-sel.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Please add acks/reviewed-bys when posting new versions.
> 

Sry, missed your ask for this patch.

-- 
regards,
-grygorii
