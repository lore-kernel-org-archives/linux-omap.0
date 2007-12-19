From: Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [RFC] [PATCH 0/2] High Speed uart support on 3430
Date: Wed, 19 Dec 2007 14:13:10 +0200
Message-ID: <47690AD6.9000409@nokia.com>
References: <02fc01c8419e$f5dfc420$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <02fc01c8419e$f5dfc420$988818ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Girish <girishsg@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext Girish wrote:
>  
> 
>> -----Original Message-----
>> From: Tony Lindgren [mailto:tony@atomide.com] 
>> Sent: Monday, December 17, 2007 11:07 PM
> 
>>> -	Data transfer Configuration(DMA mode)
>>> -	ISR registration
>>> -	UART Speed change
>> Well all that sounds good, but please move the driver to 
>> drivers/serial to start with.
> 
> This UART driver is more like an independent library which doesn't interface with serial framework so this might not fit in
> driver/serial. Any comments?

Is it possible to make a driver for omap uarts based on your library? 
Current generic drivers seems to trigger some hw(?) bugs, so at least in 
  we had to use custom serial driver. Also working power management was 
added so that clock are not used when the uart is not actually used.

-- 
Ville
