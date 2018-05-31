From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 4/6] bus: ti-sysc: Add support for using ti-sysc for
 MCAN on dra76x
Date: Thu, 31 May 2018 15:46:18 +0530
Message-ID: <0b627ab6-59f1-4a4f-42d2-5d6846adfe0b@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-5-faiz_abbas@ti.com> <20180530145726.GD5705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180530145726.GD5705@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, paul@pwsan.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 30 May 2018 08:27 PM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180530 14:12]:
>> The dra76x MCAN generic interconnect module has a its own
>> format for the bits in the control registers.
...
>>  static int sysc_init_pdata(struct sysc *ddata)
>>  {
>>  	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
>> @@ -1441,6 +1457,7 @@ static const struct of_device_id sysc_match[] = {
>>  	{ .compatible = "ti,sysc-mcasp", .data = &sysc_omap4_mcasp, },
>>  	{ .compatible = "ti,sysc-usb-host-fs",
>>  	  .data = &sysc_omap4_usb_host_fs, },
>> +	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
>>  	{  },
>>  };
> 
> Looks good to me. And presumably you checked that no other dra7 modules
> use sysconfig register bit layout like this?
> 

As far as I could see, Yes.

Thanks,
Faiz
