From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in plat_uds.c
Date: Mon, 20 Aug 2007 11:59:11 +0200
Message-ID: <46C965EF.7050508@googlemail.com>
References: <46C5C233.5090405@googlemail.com>
	<200708171402.47254.david-b@pacbell.net>
	<46C939F2.5070903@googlemail.com>
	<200708200141.48452.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200708200141.48452.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
> On Sunday 19 August 2007, Dirk Behme wrote:
> 
>>Sorry for stupid question from a non-USB expert: But what is the 
>>proposed fix for this now? ;)
>  
> Something not totally unlike the appended.  Build-tested only.

Thanks! Build-tested on DaVinci.

On OMAP seems that this conflicts with Kevins patch Tony applied some 
minutes ago:

http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commitdiff;h=84e28a2065a57efa7a1e82650949128bcd57e31a

Regards

Dirk
