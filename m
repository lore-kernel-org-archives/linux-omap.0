From: santosh.shilimkar@oracle.com
Subject: Re: [PATCHv5 00/10] soc: ti: add OMAP PRM driver (for reset)
Date: Fri, 20 Sep 2019 12:19:56 -0700
Message-ID: <13a77bd8-72bd-6a44-9141-d5492be82d82@oracle.com>
References: <20190912113916.20093-1-t-kristo@ti.com>
 <20190920142849.GS5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190920142849.GS5610@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, p.zabel@pengutronix.de, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 9/20/19 7:28 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [190912 04:39]:
>> Hi,
>>
>> V5 of the series, re-sent the whole series as one patch was dropped.
>> Changes compared to v3/v4:
>>
>> - removed dependency towards clock driver (patch #5 was completely
>>    dropped compared to v3/v4)
>> - dropped clocks property from dt binding
>> - re-added the pdata patch which was accidentally dropped out (it has
>>    dependency towards this series.)
>>
>> The new implementation (without clock driver dependency) relies on the
>> bus driver to sequence events properly, otherwise some timeouts will
>> occur either at clock driver or reset driver end.
> 
> With the two updated patches seems like we're done with this
> series?
> 
> If so, I suggest either Santosh or me sets up an immutable
> branch against v5.3 or v5.4-rc1 that we all can merge in.
> I will need it for the related dts changes at least.
> 
I will pick this up Tony and apply it once v5.4-rc1 is out.

Regards,
Santosh
