From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [RFC] Send OMAP clocksource and clockevent to rt mailing list
Date: Wed, 20 Dec 2006 22:35:49 +0100
Message-ID: <4589ACB5.1000401@gmail.com>
References: <45883982.8080207@gmail.com>
	<1166576011.6906.77.camel@vence.hilman.org>
	<45890397.2080809@gmail.com> <20061220184439.GF22783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061220184439.GF22783@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

tony@atomide.com wrote:
> * Dirk Behme <dirk.behme@googlemail.com> [061220 01:41]:
>>I now sent our clocksource/clockevent patches to -rt mailing 
>>list [1]. If clocksource goes to RMK as well, we have two 
>>paths we can get it into mainline. Let us see which is the 
>>faster and better one. The biggest risk will be some merge 
>>conflicts if both are successful ;)
> 
> No problem with merge conclicts on the RMK queue, I can easily
> refresh that patch series accordingly. So let's send what is
> needed to be included in the RT series.

I think at least our latest clocksource [1] patch should go 
to RMK.

Kevin: What's about clockevent and RMK?

Btw, I got some feedback not to send the 
clocksource/clockevent patches to -rt mailing list. Instead 
LKML should be used. I will see to find some time to send it 
to LKML as well.

Dirk

[1] 
http://linux.omap.com/pipermail/linux-omap-open-source/2006-December/008569.html
