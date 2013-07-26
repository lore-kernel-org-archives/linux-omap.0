From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/6] usb: phy-nop: Use RESET Controller for managing the
 reset line
Date: Fri, 26 Jul 2013 10:50:08 +0300
Message-ID: <51F22A30.80507@ti.com>
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
To: balbi@ti.com, p.zabel@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, benoit.cousson@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

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
Right. It isn't yet. I'm not sure about 3.12. Let's ask Philipp.

Philipp, is your GPIO Reset driver scheduled for 3.12?

cheers,
-roger
