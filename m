From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH 5/7] ARM: OMAP4: hwmod: add hwmod data for DES IP
Date: Mon, 25 Nov 2013 16:25:18 -0600
Message-ID: <5293CE4E.3090401@ti.com>
References: <1385415876-12387-1-git-send-email-joelf@ti.com>
 <1385415876-12387-6-git-send-email-joelf@ti.com>
 <20131125221111.GU10023@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131125221111.GU10023@atomide.com>
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
Cc: linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 11/25/2013 04:11 PM, Tony Lindgren wrote:
> * Joel Fernandes <joelf@ti.com> [131125 13:45]:
>> +
>> +static struct omap_hwmod_addr_space omap4_des_addrs[] = {
>> +	{
>> +		.pa_start	= 0x480A4000,
>> +		.pa_end		= 0x481A4000,
>> +		.flags		= ADDR_TYPE_RT
>> +	},
>> +	{ }
>> +};
> 
> Let's not add new address space entries. The address
> space should be already coming from device tree.
> 
Sorry, yes. that's true - I'll drop these.

thanks,

-Joel
