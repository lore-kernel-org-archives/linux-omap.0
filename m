From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix usb gadget related compile errors and
 typo
Date: Thu, 01 Nov 2007 17:28:09 +0100
Message-ID: <4729FE99.50805@googlemail.com>
References: <47263ACA.8010001@googlemail.com>
	<20071029201114.0CD6B4A69D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<47275DDC.7060002@googlemail.com>
	<200710301000.59813.david-b@pacbell.net>
	<20071101090036.GC780@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071101090036.GC780@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [071030 10:15]:
> 
>>On Tuesday 30 October 2007, Dirk Behme wrote:
>>
>>>gadget_is_otg() is defined as
>>>
>>>static inline int gadget_is_otg(struct usb_gadget *g) { ...
>>>
>>>and the call is
>>>
>>>gadget_is_otg(udc->gadget)
>>>
>>>Which fix do you propose for this?
>>
>>http://marc.info/?l=linux-usb-devel&m=119343277601632&w=2
>>
>>which is in the USB patch queue ... I thought I saw it
>>get sent to Linus recently, but maybe not.  It's not
>>in the kernel.org tree yet, unfortunately.
>  
> Pushing Dave's fix today.

And what's about the

-- cut --
--- linux-osk.orig/drivers/i2c/chips/isp1301_omap.c
+++ linux-osk/drivers/i2c/chips/isp1301_omap.c
@@ -28,7 +28,7 @@
...
-#include <linux/usb_gadget.h>
+#include <linux/usb/gadget.h>
...
-- cut --

part of

http://linux.omap.com/pipermail/linux-omap-open-source/2007-October/011804.html

?

Dirk
