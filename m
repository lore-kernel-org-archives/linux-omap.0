From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] [USB/CORE/USB.C] Fixes autosuspend and auto_pm fields
 missing
Date: Wed, 01 Nov 2006 18:09:21 +0100
Message-ID: <4548D4C1.9000405@gmail.com>
References: <4547AB5C.4010801@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4547AB5C.4010801@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi David,

Felipe Balbi wrote:
>  CC      drivers/usb/core/usb.o
> drivers/usb/core/usb.c: In function 'usb_release_dev':
> drivers/usb/core/usb.c:177: error: 'struct usb_device' has no member 
> named 'autosuspend'
> drivers/usb/core/usb.c: In function 'usb_autosuspend_work':
> drivers/usb/core/usb.c:218: error: 'struct usb_device' has no member 
> named 'auto_pm'
> drivers/usb/core/usb.c:219: warning: statement with no effect
> make[3]: *** [drivers/usb/core/usb.o] Error 1

do we have a mismatch here between usage of CONFIG_PM in 
include/linux/usb.h and CONFIG_USB_SUSPEND in usb/core/usb.c 
if CONFIG_PM isn't set for OMAP?

Cheers

Dirk

include/linux/usb.h:

#ifdef CONFIG_PM
	struct work_struct autosuspend;	/* for delayed autosuspends */
	struct mutex pm_mutex;		/* protects PM operations */

	unsigned auto_pm:1;		/* autosuspend/resume in progress */
	unsigned do_remote_wakeup:1;	/* remote wakeup should be 
enabled */
#endif

usb/core/usb.c line ~177:

#ifdef	CONFIG_USB_SUSPEND
	cancel_delayed_work(&udev->autosuspend);
...
#endif

usb/core/usb.c line ~218:

#ifdef	CONFIG_USB_SUSPEND
...
	udev->auto_pm = 1;
...
