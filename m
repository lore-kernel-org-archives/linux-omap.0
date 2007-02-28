From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH] - Fix MMC -- was  H4 boot with latest git kernel
Date: Wed, 28 Feb 2007 11:04:02 -0400
Message-ID: <45E599E2.4080301@indt.org.br>
References: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>	<20070209165157.GB22121@atomide.com>	<3B6D69C3A9EBCA4BA5DA60D913027429509132@dlee13.ent.ti.com>	<20070210174121.GA5291@atomide.com>	<20070210190845.GA19642@atomide.com>	<3B6D69C3A9EBCA4BA5DA60D9130274295B9C49@dlee13.ent.ti.com>	<45E47C35.5030707@indt.org.br>
	<3B6D69C3A9EBCA4BA5DA60D9130274296D3F9B@dlee13.ent.ti.com>
	<45E484C4.3020107@indt.org.br>
	<3B6D69C3A9EBCA4BA5DA60D9130274296D3FEE@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274296D3FEE@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext Woodruff, Richard wrote:
>>> What does not working mean?  No boot, crash on card insertion, card
>>>       
> not
>   
>>> taking some command?
>>>       
>> Card is not being recognized. The clocks are initialized, after that,
>> nothing happens when a mmc card is
>> inserted/removed. I guess it is ok for H4 once the driver does not
>>     
> support
>   
>> two MMC slots, yet.
>>     
>
> As I recall Menelaus IO companion chip really only supports 1 slot.  If
> the drivers (menelaus + mmc) are smart then menelaus can multiplexed
> between the two slots.
>
> It might be only 1 slot in the H4 port is supported (I know the state
> for the open source driver sets, even for internal version I think we
> only coded up for 1 of the 2).   Seems like at least a couple bugs exist
> in this version (mmc power up for sure, and likely menelaus-h4-port
> related)...  Does either of the slots work?
>   
Both slots aren't working.

BR,

Carlos.
> Regards,
> Richard W.
>
>   


-- 
Carlos Eduardo
Software Engineer
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
