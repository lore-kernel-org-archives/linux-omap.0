From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/6] usb: phy-nop: Use RESET Controller for managing the
 reset line
Date: Wed, 14 Aug 2013 12:31:29 +0300
Message-ID: <520B4E71.9000907@ti.com>
References: <1374137590-17865-1-git-send-email-rogerq@ti.com>
 <1374137590-17865-2-git-send-email-rogerq@ti.com>
 <20130725172855.GJ25415@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130725172855.GJ25415@radagast>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: devicetree@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 07/25/2013 08:28 PM, Felipe Balbi wrote:
> On Thu, Jul 18, 2013 at 11:53:05AM +0300, Roger Quadros wrote:
>> Till now we were modelling the RESET line as a voltage regulator and
>> using the regulator framework to manage it.
>>
>> [1] introduces a GPIO based reset controller driver. We use that
>> to manage the PHY reset line, at least for DT boots. For legacy boots,
>> will still need to use the regulator framework for reset lines.
>>
>> [1] - http://thread.gmane.org/gmane.linux.drivers.devicetree/41348
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> that's not in mainline yet, right ? Is it guaranteed that it will hit
> v3.12 merge window ?
> 

Looks like the gpio reset driver might not make it into 3.12.

Now we have two options. 

1) leave the nop-phy driver as it is
2) get rid of using regulator framework for reset line and handle the reset
gpio directly in the nop-phy driver.

Is it already too late to get (2) into 3.12 if I send the patches in a day or 2?

cheers,
-roger
