From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 46/49] undefined reference to
 `extcon_get_edev_by_phandle'
Date: Sat, 8 Apr 2017 17:28:19 -0700
Message-ID: <f086a697-1065-50e1-799a-3a7b407ac0cf@infradead.org>
References: <201704090005.8IRIdzVM%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201704090005.8IRIdzVM%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/08/17 09:29, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
> head:   9653f750a746d5abc4bc054d818eb32d1351eae9
> commit: d5a80bad699c94703a0306edd250f65cfd050580 [46/49] usb: dwc3: Add dual-role support
> config: x86_64-randconfig-h0-04081918 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         git checkout d5a80bad699c94703a0306edd250f65cfd050580
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/built-in.o: In function `dwc3_drd_init':
>>> (.text+0x2aff13): undefined reference to `extcon_get_edev_by_phandle'
>    drivers/built-in.o: In function `dwc3_drd_init':
>>> (.text+0x2affb1): undefined reference to `extcon_register_notifier'
>    drivers/built-in.o: In function `dwc3_drd_init':
>>> (.text+0x2b0029): undefined reference to `extcon_get_state'
>    drivers/built-in.o: In function `dwc3_drd_exit':
>>> (.text+0x2b00e1): undefined reference to `extcon_unregister_notifier'

EXTCON=m in this config.

DWC3_DUAL_ROLE needs to depend on EXTCON...


-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
