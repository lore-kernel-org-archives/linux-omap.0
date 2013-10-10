From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 5/6] Revert "ARM: OMAP2+: Provide alias to USB PHY
 clock"
Date: Thu, 10 Oct 2013 12:15:43 +0300
Message-ID: <5256703F.1070806@ti.com>
References: <1381226799-29158-1-git-send-email-rogerq@ti.com>
 <1381226799-29158-6-git-send-email-rogerq@ti.com> <52550180.1000506@ti.com>
 <20131009151522.GA8313@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131009151522.GA8313@atomide.com>
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
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/09/2013 06:15 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [131009 00:19]:
>> Hi Tony,
>>
>> On 10/08/2013 01:06 PM, Roger Quadros wrote:
>>> This reverts commit 741532c4a995be11815cb72d4d7a48f442a22fea.
>>>
>>> The proper clock reference is provided in device tree so we
>>> no longer need this.
>>
>> Could you please Ack this one? I think it is best if it goes through Benoit's tree.
> 
> I could queue this into my board removal series that will be
> based on Benoit's branch if that works for you. And this
> also seems to depend on the omap-for-v3.13/quirk branch
> that moves all the legacy pdata handling into pdata-quirks.c.

OK Tony. Thanks.

cheers,
-roger
