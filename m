From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 23/24] ARM: OMAP2+: Allow clock alias provision from device
 tree
Date: Tue, 12 Mar 2013 16:01:15 +0200
Message-ID: <513F352B.3050608@ti.com>
References: <1363088606-2692-1-git-send-email-rogerq@ti.com>
 <1363088606-2692-24-git-send-email-rogerq@ti.com> <513F2AEB.8070702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <513F2AEB.8070702-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

On 03/12/2013 03:17 PM, Benoit Cousson wrote:
> Hi Roger,
> 
> On 03/12/2013 12:43 PM, Roger Quadros wrote:
>> Currently on OMAP, it is not possible to specify a clock consumer
>> to any of the OMAP generated clocks using the device tree. This can pose
>> a problem for external devices that run off an OMAP clock as we
>> can't reliably provide a reference to the clock in the device tree.
> 
> I'm really confused by that statement... Why cannot you use the current
> clock binding definition?
> 
> The point is that we should avoid defining temporary custom bindings.
> Especially when a generic one already exist.
> 
> I know you already discussed that on the list, but I cannot really find
> the rational in the previous thread.
> 
> Here is a quote from the original "Subject: Re: how to specify an OMAP
> clock in device tree?" thread.
> 
>> /* provider */
>> clks: omapclocks {
>>         compatible = "ti,omapclocks";
>>         #clock-cells = <1>;
>> };
>>
>> /* consumer */
>> hsusb1_phy: hsusb1_phy {
>> 	compatible = "usb-nop-xceiv";
>> 	clocks = <&clks "auxclk3_ck">;	/* FREF_CLK3 */
>> 	clock-names = "main-clk";
>> };
>>
>> The only problem I see is that the argument to the clks phandle
>> cannot be a string. It needs to be u32.
>>
>> In that case we need to map all clocks into a u32 index.
>>
>> If we can do that only for auxclks, my problem is solved for panda.
> 
> phandle is u32 as always, but you should not care about that.
> What you care about is the clock node referenced by the phandle, not the
> phandle itself.
> 
> What is missing right now is a proper of_clk_add_provider call to
> declare a generic OMAP clock provider and thus allow OMAP clocks to be
> used with DT.
> 
> The AUXCLOCKs are managed by the SCRM which is outside the PRCM, so you
> should be able to add a clock providers dedicated to the SCRM clocks only.

Okay, I will convert at least the SCRM clocks to be provided by device tree.

Tony,

Please drop this patch and patch 24. The rest should be fine.
Just that Panda EHCI won't work till we have the PHY clock correctly
provided.

cheers,
-roger
