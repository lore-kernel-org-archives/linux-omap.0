From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/6] Init Clock frequences for accelerators
Date: Mon, 12 Jun 2017 11:32:37 +0300
Message-ID: <ea1b56dd-1a91-42a1-6247-2acd0dcc1dab@ti.com>
References: <20170607212730.33002-1-s-anna@ti.com>
 <20170612073635.GT3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170612073635.GT3730@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Subhajit Paul <subhajit_paul@ti.com>
List-Id: linux-omap@vger.kernel.org

On 12/06/17 10:36, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [170607 14:31]:
>> Hi Tony,
>>
>> The following series configures the initial frequencies for the required
>> DPLLs and corresponding output divider clocks used by various remoteproc
>> accelerators (DSP, IVAHD) on OMAP4, OMAP5 & DRA7xx/AM57xx SoCs and the
>> GPU on DRA7xx/AM57xx SoCs. All these devices require Adaptive Voltage
>> Scaling (AVS) to be programmed at all OPPs at boot time, which is
>> programmed in the bootloader. Furthermore, DVFS is not supported on
>> these domains implying a one-time OPP clock frequency setup.
> 
> Tero, care to comment or ack this series?

These have been in use in TI releases for quite a while already, and 
look fine, thus:

Acked-by: Tero Kristo <t-kristo@ti.com>

(Didn't quite think my ack was needed for them so didn't respond 
earlier, sorry.)
