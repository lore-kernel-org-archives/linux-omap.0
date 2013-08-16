From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH v3] arm: dts: AM43x: Add usb DT nodes for AM4372
Date: Fri, 16 Aug 2013 15:51:09 +0530
Message-ID: <520DFD15.9060900@ti.com>
References: <1373444082-4169-1-git-send-email-george.cherian@ti.com>
 <520B9144.5000701@ti.com> <520B958B.1000900@baylibre.com>
 <520D9A3E.1040903@ti.com> <520DEBF1.6070605@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <520DEBF1.6070605@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: afzal@ti.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, balbi@ti.com, a-kishore@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On 8/16/2013 2:38 PM, Benoit Cousson wrote:
> That's fine, but that was not my question. Is there any already bindings
> that defined phys and phy-names in the kernel?

No
>
> I couldn't find them in 3.11-rc5.

I will drop the phy reference and send an updated patch adding dwc nodes.

> And anyway the current bindings for dwc3 is not aligned with what you
> are doing here.
> So you have to change the binding before using it in this DTS.
>
> Regards,
> Benoit


-- 
-George
