From: Grigor Tovmasyan <Grigor.Tovmasyan-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 45/57] drivers/usb/dwc2/core.c:438:13:
 error: static declaration of 'dwc2_clear_force_mode' follows non-static
 declaration
Date: Thu, 15 Feb 2018 14:37:40 +0000
Message-ID: <32EB88BF8EC1614E9FB18BD3718BE1A1163CD935@am04wembxa.internal.synopsys.com>
References: <201802152134.OH8x0B2I%fengguang.wu@intel.com>
 <87bmgq8jj2.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grigor Tovmasyan <Grigor.Tovmasyan-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "kbuild-all-JC7UmRfGjtg@public.gmane.org" <kbuild-all-JC7UmRfGjtg@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Balbi

On 2/15/2018 17:34, Felipe Balbi wrote:
> 
> Hi,
> 
> kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
>> tree:   https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_balbi_usb.git&d=DwIFAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=K1ULVL1slpLXpMJJlAXSOxws4tRq0IkTBqxDkyW2hUQ&m=2Hq2CZMELUidsi9x-Kqf4yuAh4IoxCX3Th1gZtmyZmc&s=Kw25jbj17VVP-cEEsCvpsfmS6NIuM8JAI8vfOtC2Nt4&e= testing/next
>> head:   65223a0ed97c8c4b18c4899653745058f87d67e3
>> commit: 4caf1fe8fb537388810a4c8fecfa5324b26f80ea [45/57] usb: dwc2: Make dwc2_force_mode() static
>> config: i386-randconfig-x072-201806 (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> reproduce:
>>          git checkout 4caf1fe8fb537388810a4c8fecfa5324b26f80ea
>>          # save the attached .config to linux build tree
>>          make ARCH=i386
>>
>> All errors (new ones prefixed by >>):
>>
>>>> drivers/usb/dwc2/core.c:438:13: error: static declaration of 'dwc2_clear_force_mode' follows non-static declaration
>>      static void dwc2_clear_force_mode(struct dwc2_hsotg *hsotg)
>>                  ^~~~~~~~~~~~~~~~~~~~~
>>     In file included from drivers/usb/dwc2/core.c:57:0:
>>     drivers/usb/dwc2/core.h:1101:6: note: previous declaration of 'dwc2_clear_force_mode' was here
>>      void dwc2_clear_force_mode(struct dwc2_hsotg *hsotg);
>>           ^~~~~~~~~~~~~~~~~~~~~
>>
>> vim +/dwc2_clear_force_mode +438 drivers/usb/dwc2/core.c
>>
>>     428	
>>     429	/**
>>     430	 * dwc2_clear_force_mode() - Clears the force mode bits.
>>     431	 *
>>     432	 * After clearing the bits, wait up to 100 ms to account for any
>>     433	 * potential IDDIG filter delay. We can't know if we expect this delay
>>     434	 * or not because the value of the connector ID status is affected by
>>     435	 * the force mode. We only need to call this once during probe if
>>     436	 * dr_mode == OTG.
>>     437	 */
>>   > 438	static void dwc2_clear_force_mode(struct dwc2_hsotg *hsotg)
> 
> patch dropped.
> 

This patch have a dependency from "[PATCH 6/6] usb: dwc2: Force mode"
("[PATCH 0/6] usb: dwc2: minor fixes" patches) which I missed.

I will rebase
[PATCH 5/6] usb: dwc2: eliminate irq parameter from dwc2_gadget_init
[PATCH 6/6] usb: dwc2: Force mode

Please apply this patch after applying that two patches.

Thanks, Grigor.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
