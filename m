From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Thu, 8 Aug 2013 11:03:18 -0400
Message-ID: <5203B336.90102@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-9-git-send-email-d-gerlach@ti.com>
 <CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
 <52038E88.2050604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52038E88.2050604@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Russ Dill <russ.dill@gmail.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tony Lingren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

$subject and patch don't match.

On Thursday 08 August 2013 08:26 AM, Nishanth Menon wrote:
> On 08/08/2013 03:45 AM, Russ Dill wrote:
>>   In reference to
>> the M3 handling it, the M3 wouldn't know which devices have a driver
>> bound and which don't.
> Does it need to? M3 firmware can pretty much define "I will force the device into low power state, and if the drivers dont handle things properly, fix the darned driver". M3 behavior should be considered as a "hardware" as far as Linux running on MPU is concerned, and firmware helps change the behavior by accounting for SoC quirks. *if* we have ability to handle this in the firmware, there is no need to carry this in Linux.
> 
I agree with Nishant. I don't like this patch and IIRC, I gave same
comment in the last version. Linux need not know about all such firmware
quirks. Also all these M3 specific stuff, should be done somewhere
else. Probably having a small M3 driver won't be a bad idea.

Regards,
Santosh
