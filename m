From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v5 3/9] mfd: omap-usb-host: Update DT clock binding
 information
Date: Mon, 20 Jan 2014 11:14:55 +0200
Message-ID: <52DCE90F.8040908@ti.com>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com>
 <1389269303-30465-4-git-send-email-rogerq@ti.com>
 <20140110101107.GF28141@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140110101107.GF28141@lee--X1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: mark.rutland@arm.com, m.paolino@virtualopensystems.com, Samuel Ortiz <sameo@linux.intel.com>, arnd@arndb.de, devicetree@vger.kernel.org, tony@atomide.com, sre@debian.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/10/2014 12:11 PM, Lee Jones wrote:
> On Thu, 09 Jan 2014, Roger Quadros wrote:
> 
>> The omap-usb-host driver expects certained named clocks.
>> Add this information to the DT binding document.
>>
>> Use clock names as per function for reference clocks.
>>
>> CC: Lee Jones <lee.jones@linaro.org>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  .../devicetree/bindings/mfd/omap-usb-host.txt      | 23 ++++++++++++++++++++++
>>  drivers/mfd/omap-usb-host.c                        |  6 +++---
>>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> Please don't mix up binding changes with code ones.
> 
> Separate patch please.
> 
OK.

cheers,
-roger
