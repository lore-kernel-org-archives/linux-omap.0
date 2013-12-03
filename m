From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 1/7] usb: dwc3: get "usb_phy" only if the platform
 indicates the presence of PHY's
Date: Tue, 3 Dec 2013 15:20:39 +0530
Message-ID: <529DA96F.3000903@ti.com>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
 <1381866857-3861-2-git-send-email-kishon@ti.com>
 <20131017163828.GH11611@gimli> <5280EB5C.1040001@ti.com>
 <20131125213213.GV18046@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131125213213.GV18046@saruman.home>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux@arm.linux.org.uk, bcousson@baylibre.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, gregkh@linuxfoundation.org, swarren@wwwdotorg.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, rob@landley.net, galak@codeaurora.org, grant.likely@linaro.org, s.nawrocki@samsung.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 26 November 2013 03:02 AM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Nov 11, 2013 at 08:06:12PM +0530, Kishon Vijay Abraham I wrote:
>>>> diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
>>>> index 7db34f0..49ffa6d 100644
>>>> --- a/drivers/usb/dwc3/platform_data.h
>>>> +++ b/drivers/usb/dwc3/platform_data.h
>>>> @@ -24,4 +24,6 @@ struct dwc3_platform_data {
>>>>  	enum usb_device_speed maximum_speed;
>>>>  	enum usb_dr_mode dr_mode;
>>>>  	bool tx_fifo_resize;
>>>> +	bool usb2_phy;
>>>> +	bool usb3_phy;
>>>
>>> This would look better as a quirks flag, then we could:
>>>
>>> unsigned long quirks;
>>> #define DWC3_QUIRK_NO_USB3_PHY	BIT(0)
>>> #define DWC3_QUIRK_NO_USB2_PHY	BIT(1)
>>
>> Should this quirk be used for dt also? Currently we find if it has usb3 phy or
>> usb2 phy from the dt data only. But if we add a quirk, we'll have to add a
>> property to populate the quirk no?
> 
> either we use the quirk, or use the fact that no <&usb2_phy> phandle is
> defined, would work both ways, no ?

In my v3, I've made both to use quirks since we don't want to have separate
mechanism for dt and non-dt stuff to know the presence of a particular PHY.

Thanks
Kishon
