From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Pending October patches
Date: Fri, 3 Nov 2006 02:50:04 -0800 (PST)
Message-ID: <20061103105004.70334.qmail@web37904.mail.mud.yahoo.com>
References: <454A2431.9010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <454A2431.9010007@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>, tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Dirk Behme <dirk.behme@googlemail.com> wrote:

> tony@atomide.com wrote:
> >>9. [PATCH] ARM: OMAP: Fix warnings in plat-omap/dsp
>
>>http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008185.html
> > 
> > I think the unlikely() is unlikely necessary for init and sysfs?
> 
> Thanks for review! It was just a mechanical search & replace 
> without any look to the functions itself. Will update this 
> and the others soon.


Also, these patches doesn't put proper error return path, as we don't
know, if some userspace tool can't work if those sysfs files are not
created at probe.

> 
> >>26. [PATCH] ARM: OMAP: Make AIC23 sound work again
>
>>http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008232.html
> > 
> > Hmmm, I think there were some comments on this hack on LKML when we
> > merged the driver?
> 
> Komal, what do you think here?
> 
> Anybody aware of someone working on a better solution? Any 
> link to the LKML discussion about this?
> 

Few links:

http://lkml.org/lkml/2006/8/2/138
http://lkml.org/lkml/2006/8/5/23
http://lkml.org/lkml/2006/7/31/366
http://linux.omap.com/pipermail/davinci-linux-open-source/2006-October/001332.html

on google following keywords can help

site:lkml.org/lkml Komal Shah OMAP I2C

---Komal Shah
http://komalshah.blogspot.com/


 
____________________________________________________________________________________
Get your email and see which of your friends are online - Right on the New Yahoo.com 
(http://www.yahoo.com/preview) 
