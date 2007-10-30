From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix usb gadget related compile errors and
 typo
Date: Tue, 30 Oct 2007 17:37:48 +0100
Message-ID: <47275DDC.7060002@googlemail.com>
References: <47263ACA.8010001@googlemail.com>
	<20071029201114.0CD6B4A69D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071029201114.0CD6B4A69D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
>>- * gadget_is_dualspeed - return true iff the hardware handles high speed
>>+ * gadget_is_dualspeed - return true if the hardware handles high speed
> 
> Not a typo; "iff" == "if and only if".  NAK to that part.

Sorry. Sometimes its hard to be a non-native speaker ;)

> Re the other, please make those parts match what's upstream;

Creating the patch ~3 hours after Tonys "update linux-omap to mainline 
tree" I assumed OMAP git was in sync with mainline.

> I think you added extra parens.

Yes. I tried to fix this compilation error:

   CC      drivers/usb/gadget/omap_udc.o
drivers/usb/gadget/omap_udc.c: In function 'pullup_enable':
drivers/usb/gadget/omap_udc.c:1244: error: incompatible type for 
argument 1 of 'gadget_is_otg'
drivers/usb/gadget/omap_udc.c: In function 'pullup_disable':
drivers/usb/gadget/omap_udc.c:1251: error: incompatible type for 
argument 1 of 'gadget_is_otg'
drivers/usb/gadget/omap_udc.c: In function 'update_otg':
drivers/usb/gadget/omap_udc.c:1389: error: incompatible type for 
argument 1 of 'gadget_is_otg'

gadget_is_otg() is defined as

static inline int gadget_is_otg(struct usb_gadget *g) { ...

and the call is

gadget_is_otg(udc->gadget)

Which fix do you propose for this?

Best regards

Dirk
