From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1
 CPU devices
Date: Tue, 13 Aug 2013 09:31:04 -0400
Message-ID: <520A3518.3030301@ti.com>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com>
 <51FBC610.9030900@arm.com> <51FBCEC3.4030207@ti.com>
 <51FBD42A.9040901@arm.com> <20130802154857.GD5292@mudshark.cambridge.arm.com>
 <52092AA5.3090005@ti.com> <20130813111943.GE30280@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130813111943.GE30280@mudshark.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Vaibhav Bedia <vaibhav.bedia@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 13 August 2013 07:19 AM, Will Deacon wrote:
> On Mon, Aug 12, 2013 at 07:34:13PM +0100, Santosh Shilimkar wrote:
>> On Friday 02 August 2013 11:48 AM, Will Deacon wrote:
>>> I think this an A9-specific register, which reads as 0 on UP A9 and reads as
>>> some form of PERIPH_BASE for SMP parts. The issue I have is when PERIPH_BASE
>>> is zero.
>>>
>> What do we do here ? Should we document this in the code and proceed ?
>> Mostly there is no platform with PERIPH_BASE = 0, so its should be fine but
>> I am open for any other alternative.
> 
> The only other alternative I can think of is forcing people to have
> CONFIG_SMP=n, but that blows away single zImage for your platform.
> 
Yep which surely we don't want considering after so much effort we
have it working first place. How about going ahead with assumption
that PERIPH_BASE = 0 case doesn't work.

Regards,
Santosh
