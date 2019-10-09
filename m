From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCHv8 0/9] soc: ti: add OMAP PRM driver (for reset)
Date: Wed, 9 Oct 2019 09:01:42 -0700
Message-ID: <5e10f95c-7ec9-d3a7-6862-f6f07a9c1495@oracle.com>
References: <20191008125544.20679-1-t-kristo@ti.com>
 <20191008140002.GY5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191008140002.GY5610@atomide.com>
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
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, p.zabel@pengutronix.de, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/8/19 7:00 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [191008 05:56]:
>> Hi,
>>
>> Hopefully this is the final revision of the series. Just a repost of v7
>> with the single comment from Philipp fixed, and added reviewed by tags
>> from him for couple of the patches.
> 
> Santosh, when applying these, can you please provide me an immutable
> branch maybe against v5.4-rc1 that I can use as the base for the related
> dts changes?
> 
> For the whole series where not already done, please feel free to add:
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> 
Pushed a branch out with series and your reviewed-by tag. I have tagged
it yet in case Peter's soc patches get ready.

git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git 
for_5.5/driver-soc
