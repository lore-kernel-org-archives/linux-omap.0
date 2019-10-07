From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/3] bus: ti-sysc: fix reset sequencing
Date: Mon, 7 Oct 2019 22:00:16 +0300
Message-ID: <32031606-23da-2e0b-6d75-7225a082eb6b@ti.com>
References: <20191007122931.18668-1-t-kristo@ti.com>
 <20191007163807.GU5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191007163807.GU5610@atomide.com>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/10/2019 19:38, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [191007 12:30]:
>> Hi,
>>
>> These three patches make sure that IOMMU/remoteprocs work across
>> all devices with the latest OMAP PRM series for reset support [1].
>> The last dangling issues were caused by the removal of the hardlink
>> between the reset + clock drivers.
> 
> OK. I presume these are safe to wait for v5.5 since we don't
> have the rstctrl driver yet?

Yeah, they are safe to wait.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
