From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in plat_uds.c
Date: Fri, 17 Aug 2007 18:39:05 +0200
Message-ID: <46C5CF29.2020601@googlemail.com>
References: <46C5C233.5090405@googlemail.com>
	<31e679430708170912p1bd8050dg38db45d14d237961@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <31e679430708170912p1bd8050dg38db45d14d237961@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote:
> Hi,

Thanks for review!

> On 8/17/07, Dirk Behme <dirk.behme@googlemail.com> wrote:
> 
>>Fix warning
>>
>>drivers/usb/musb/plat_uds.c:1731: warning: 'dev_attr_srp' defined but
>>not used
>>
>>if CONFIG_USB_MUSB_OTG isn't set (DaVinci use case)
>>
>>Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>>
>>Index: linux-davinci/drivers/usb/musb/plat_uds.c
>>===================================================================
>>--- linux-davinci.orig/drivers/usb/musb/plat_uds.c
>>+++ linux-davinci/drivers/usb/musb/plat_uds.c
>>@@ -1707,6 +1707,7 @@ musb_vbus_show(struct device *dev, struc
>> }
>> static DEVICE_ATTR(vbus, 0644, musb_vbus_show, musb_vbus_store);
>>
>>+#ifdef CONFIG_USB_MUSB_OTG
>> static ssize_t
>> musb_srp_store(struct device *dev, struct device_attribute *attr,
>>                const char *buf, size_t n)
>>@@ -1728,8 +1729,11 @@ musb_srp_store(struct device *dev, struc
>>
>>        return n;
>> }
>>+
>>+
>> static DEVICE_ATTR(srp, 0644, NULL, musb_srp_store);
>> #endif
>>+#endif
> 
> 
> this doesn't look right since any device can issue SRP. It's better
> for you to use it somewhere on DaVinci.

Sorry, if I missed anything. Looking to recent plat_uds.c of OMAP, 
dev_attr_srp is used at two places encapsulated by CONFIG_USB_MUSB_OTG:

#ifdef CONFIG_USB_MUSB_OTG
	status = device_create_file(dev, &dev_attr_srp);
#endif /* CONFIG_USB_MUSB_OTG */

#ifdef CONFIG_USB_MUSB_OTG
	device_remove_file(musb->controller, &dev_attr_srp);
#endif

I think that's the reason for warning

drivers/usb/musb/plat_uds.c:1731: warning: 'dev_attr_srp' defined but 
not used

if CONFIG_USB_MUSB_OTG isn't set? What do do you propose instead to 
get rid of this warning on OMAP?

Dirk
