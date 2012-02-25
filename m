From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 5/6] ARM: OMAP3: Modify omap_hsmmc_late_init to handle
 deleting mmc devices
Date: Sat, 25 Feb 2012 10:15:50 +0530
Message-ID: <4F48677E.30803@ti.com>
References: <1330077537-19618-1-git-send-email-rnayak@ti.com>
 <1330077537-19618-6-git-send-email-rnayak@ti.com>
 <20120225003352.GC18901@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120225003352.GC18901@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Saturday 25 February 2012 06:03 AM, Tony Lindgren wrote:
> Hi,
>
> * Rajendra Nayak<rnayak@ti.com>  [120224 01:27]:
>> omap_hsmmc_late_init() adds deferred (if any) mmc devices which are
>> dependent on twl4030-gpio device to be available.
>> If twl4030-gpio is built as a module and inserted and deleted multiple
>> times, the mmc devices also should be added and deleted accordingly.
>> Split omap_hsmmc_late_init() into omap_hsmmc_deferred_add() and
>> omap_hsmmc_deferred_del() to handle this.
>> The .setup board hook for twl4030-gpio handles the runtime adding
>> on deferred mmc devices. Similarly a .teardown board hook for twl4030-gpio
>> should handle the runtime deletion by calling omap_hsmmc_deferred_del().
>> This is done for all existing omap3 boards in subsequent patches.
>
> This gets complex.. But I think I've found a simpler way where we
> can use the twl gpio offsets and let the drivers take care of the rest.
> I'll post some patches hopefully on Monday.

I agree it gets complex. If you have a simpler way to handle this, that
would be great.

regards,
Rajendra
>
> Regards,
>
> Tony
