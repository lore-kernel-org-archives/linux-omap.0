From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Sat, 02 Dec 2006 08:06:29 +0100
Message-ID: <457125F5.5090102@gmail.com>
References: <4550A70B.7020609@gmail.com> <4550CA9E.6090500@mvista.com>	
	<456F1B1E.1050305@gmail.com>
	<1164909003.17665.1.camel@imap.mvista.com>	
	<45705464.3070105@gmail.com>
	<1165029705.2964.9.camel@imap.mvista.com>	
	<4571192D.8040807@gmail.com>
	<1165042487.15319.11.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1165042487.15319.11.camel@imap.mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Walker <dwalker@mvista.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Daniel Walker wrote:
> On Sat, 2006-12-02 at 07:11 +0100, Dirk Behme wrote:
> 
>>>When Thomas did his -mm update all the clocksources got dropped
>>
>>I'm not talking about (OMAP) clocksource here. I'm talking 
>>about the rest [3], especially OMAP clockevent patch.
> 
> ok.
> 
>>- OMAP clockevent is potentially something for this list as 
>>well. But currently, it isn't discussed here and I can't 
>>find it discussed or included anywhere else. So it looks to 
>>me that it is lost (until anybody cares again). This is the 
>>core of my question: Is it currently nowhere maintained?
> 
> I guess Kevin and I maintain it. It's not such a large piece of code.
> The reason that it's not getting pushed hard at the moment is because
> HRT is testing in -mm .. So we're at a limbo point when we can't move
> the code to RMK, and it's not really appropriate for the code to go into
> -mm .. We just have to wait till HRT gets shaken out in -mm .
> 
> The reason we are able to send the clocksource to RMK is cause generic
> time went into the 2.6.18 stable release.
> 
>>- The other patches, e.g. for ixp4xx and versatile, I think 
>>nobody will care on this list and update them here. So until 
>>they are not handled somewhere else (are they?), they will 
>>be lost as well.
>>
>>>Nothing should go via Thomas.
>>
>>You originally sent most of the patches to Thomas, don't you? ;)
> 
> Yes, before HRT went to -mm. The reason that it was useful to send them
> to Thomas was for our own testing, and progressing HRT at an early
> point. I wouldn't have minded if the OMAP clockevents when into -mm ,
> but I've never seen anything like that happen (i.e. non-i386 board
> specific code going into -mm).

Okay. Many thanks for clarifying these tricky dependencies!

Looks like then nothing is lost, only "waiting". Would be 
nice if you can keep us updated regarding this.

Dirk
