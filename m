From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in plat_uds.c
Date: Mon, 20 Aug 2007 08:51:30 +0200
Message-ID: <46C939F2.5070903@googlemail.com>
References: <46C5C233.5090405@googlemail.com>
	<200708171130.21974.david-b@pacbell.net>
	<31e679430708171336g318ad89er59e9246c5c839f04@mail.gmail.com>
	<200708171402.47254.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200708171402.47254.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>, Felipe Balbi <felipebalbi@users.sourceforge.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
> On Friday 17 August 2007, Felipe Balbi wrote:
> 
>>Maybe my previous mail didn't get to list yet but I sent an email
>>telling Dirk to get rid of the ifdef CONFIG_USB_MUSB_OTG.
>>
>>Does that seem better for you?
> 
> Host-only systems shouldn't have that SRP support.

Sorry for stupid question from a non-USB expert: But what is the 
proposed fix for this now? ;)

Regards

Dirk
