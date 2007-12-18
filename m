From: "Girish" <girishsg@ti.com>
Subject: RE: [RFC] [PATCH 0/2] High Speed uart support on 3430
Date: Tue, 18 Dec 2007 23:23:53 +0530
Message-ID: <02fc01c8419e$f5dfc420$988818ac@ent.ti.com>
References: <20071217173658.GF7388@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071217173658.GF7388@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com] 
>Sent: Monday, December 17, 2007 11:07 PM

>> -	Data transfer Configuration(DMA mode)
>> -	ISR registration
>> -	UART Speed change
>
>Well all that sounds good, but please move the driver to 
>drivers/serial to start with.

This UART driver is more like an independent library which doesn't interface with serial framework so this might not fit in
driver/serial. Any comments?

Regards,
Girish
