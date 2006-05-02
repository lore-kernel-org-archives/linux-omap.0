From: Kevin Hilman <khilman@mvista.com>
Subject: Re: omap mmc build errors
Date: Tue, 02 May 2006 14:24:50 -0700
Message-ID: <4457CE22.8050702@mvista.com>
References: <443BAD8C.4090005@indt.org.br>	<20060413151756.47512.qmail@web32901.mail.mud.yahoo.com>
	<20060502092025.GC24728@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060502092025.GC24728@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Komal Shah <komal_shah802003@yahoo.com> [060413 08:18]:
>> --- Carlos Aguiar <carlos.aguiar@indt.org.br> wrote:
>>
>>> Hi Komal and folks,
>>>
>>> You have to apply a patch that Tony sent to the list 7 days ago. This
>>>
>>> patch corrects the bugs mentioned above. Attached to this mail follow
>>>
>> You still need the attached patch on top of the Tony's patch to build
>> it successfully.
> 
> I've just pushed that patch + fixed trying to ioremap a virtual address.
> Seems to work now, can you test?

Haven't had time to dig, but this builds but doesn't boot on 1710/H3.  Simply 
disabling CONFIG_MMC_OMAP makes it boot.

Kevin
