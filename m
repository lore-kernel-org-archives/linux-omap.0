From: Felipe Balbi <ext-felipe.lima@nokia.com>
Subject: [ERROR]: -ENODEV Error!
Date: Mon, 06 Nov 2006 14:52:56 -0400
Message-ID: <454F8488.6010806@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello all,

I'm getting some "No such Device" messages when loading any of the g_* 
modules.
I was trying to hack omap_udc.c and I figured out the error is with the 
first "sanity test", as called in the source-code:

int usb_gadget_register_driver (struct usb_gadget_driver *driver)
{
        int             status = -ENODEV;
        struct omap_ep  *ep;
        unsigned long   flags;

        /* basic sanity tests */
        if (!udc)       <---- THIS IS GIVING ME THE ERROR... I COMMENTED 
THIS AND
                return -ENODEV;
        if (!driver 
                        // FIXME if otg, check:  driver->is_otg
                        || driver->speed < USB_SPEED_FULL
                        || !driver->bind
                        || !driver->unbind
                        || !driver->setup)    <------ THIS GAVE ME 
ANOTHER BUG!!! :-P
                return -EINVAL;

        spin_lock_irqsave(&udc->lock, flags);
        if (udc->driver) {
                spin_unlock_irqrestore(&udc->lock, flags);
                return -EBUSY;
        }


The error:
# modprobe g_serial
udc: OMAP UDC driver, version: 4 October 2004 (iso) (dma)
udc: OMAP UDC rev 6.1, Mini-AB
gs_module_init: cannot register gadget driver, ret=-19
FATAL: Error inserting g_serial 
(/lib/modules/2.6.19-rc4-omap1-gfb280632-dirty/kernel/drivers/usb/gadget/g_serial.ko): 
No such device

-- 
Best Regards,

Felipe Balbi
ext-felipe.lima@nokia.com
OSMRC - INdT
