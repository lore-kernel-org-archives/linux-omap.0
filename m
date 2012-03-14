From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: i2c, gpio, spi and regulator DTS updates
Date: Thu, 15 Mar 2012 00:04:04 +0100
Message-ID: <4F6123E4.5090808@ti.com>
References: <4F5E89B4.4010505@ti.com> <4F6120A5.6050407@ti.com>
 <20120314225743.GT12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120314225743.GT12083@atomide.com>
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
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On 3/14/2012 11:57 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [120314 15:52]:
>> Hi Tony,
>>
>> It looks like Chris Ball just queued  the HSMMC DT stuff from
>> Rajendra, so I can add as well the MMC DTS for OMAP3 and OMAP4 as
>> well.
>>
>> It is fine for an update?
>
> Sure, I'm not planning to pull this until after the merge
> window.

OK, so we will not have the DTS support for the new drivers for 3.4 :-(

Well, if you pull that in a lo branch, that will be enough to base the 
further work on it.

>> Than I can add as Kevin's patch for twl irq_base removal.
>
> Hmm I don't follow. That's needed first as a fix for the
> merge window?

No, not that one. It is just some more cleanup on top of the one Felipe 
already did in the twl series I've just sent to Samuel.
But if you do not plan to pull that series for 3.4, that does not really 
matter.

Regards,
Benoit
