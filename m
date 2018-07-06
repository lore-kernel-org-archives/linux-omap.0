From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v4 4/6] bus: ti-sysc: Add support for software reset
Date: Fri, 6 Jul 2018 15:34:31 +0530
Message-ID: <cf8652a1-019c-d423-9b44-0d62006734f8@ti.com>
References: <20180705142319.19583-1-faiz_abbas@ti.com>
 <20180705142319.19583-5-faiz_abbas@ti.com>
 <20180705154758.GA112168@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180705154758.GA112168@atomide.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, paul@pwsan.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 05 July 2018 09:17 PM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180705 14:24]:
>> +static int sysc_reset(struct sysc *ddata)
>> +{
>> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
>> +	int val = sysc_read(ddata, offset);
> 
> Can you please just warn and return early for now if no
> syss_mask is specified? Otherwise we'll have mysterious
> errors if somebody leaves out "ti,hwmods" for module types
> we do not yet support reset for.

RESET write to sysconfig can still happen even if there's no syss_mask
right? Not all modules need to poll on reset status.

Thanks,
Faiz
