From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Pending October patches
Date: Thu, 02 Nov 2006 18:00:33 +0100
Message-ID: <454A2431.9010007@gmail.com>
References: <4548C32E.8010800@gmail.com> <20061101212850.GD6833@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061101212850.GD6833@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com, Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

tony@atomide.com wrote:
>>9. [PATCH] ARM: OMAP: Fix warnings in plat-omap/dsp
>>http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008185.html
> 
> I think the unlikely() is unlikely necessary for init and sysfs?

Thanks for review! It was just a mechanical search & replace 
without any look to the functions itself. Will update this 
and the others soon.

>>26. [PATCH] ARM: OMAP: Make AIC23 sound work again
>>http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008232.html
> 
> Hmmm, I think there were some comments on this hack on LKML when we
> merged the driver?

Komal, what do you think here?

Anybody aware of someone working on a better solution? Any 
link to the LKML discussion about this?

Best regards

dirk
