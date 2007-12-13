From: "Girish" <girishsg@ti.com>
Subject: RE: [PATCH] twl4030-rtc support on 3430
Date: Thu, 13 Dec 2007 16:22:20 +0530
Message-ID: <008c01c83d76$3cae4bb0$988818ac@ent.ti.com>
References: <475D680E.7040802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <475D680E.7040802@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Dmitry Krivoschekov' <dmitry.krivoschekov@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: Dmitry Krivoschekov [mailto:dmitry.krivoschekov@gmail.com] 
>Sent: Monday, December 10, 2007 9:54 PM

>> This patch supports TWL4030 RTC on 3430 and adds periodic 
>interrupts functionality through framework. Also, some code cleanup.
>>

>> + * 		bit 2: every hour
>> + * 		bit 3: every day
>> + */
>
>Note, this breaks an assumption that freq is measured in Hz. 
>For example, RTC Driver Test/Example Program won't pass the 
>"test_PIE" part.

Indeed the freq is measured in Hz, may be I'll remove the comments to avoid confusion.
>
>
>Regards,
>Dmitry
>
>
>
