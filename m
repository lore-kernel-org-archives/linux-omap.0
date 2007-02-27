From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [PATCH] - Fix MMC -- was  H4 boot with latest git kernel
Date: Tue, 27 Feb 2007 15:21:40 -0400
Message-ID: <45E484C4.3020107@indt.org.br>
References: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>	<20070209165157.GB22121@atomide.com>	<3B6D69C3A9EBCA4BA5DA60D913027429509132@dlee13.ent.ti.com>	<20070210174121.GA5291@atomide.com>	<20070210190845.GA19642@atomide.com>	<3B6D69C3A9EBCA4BA5DA60D9130274295B9C49@dlee13.ent.ti.com>	<45E47C35.5030707@indt.org.br>
	<3B6D69C3A9EBCA4BA5DA60D9130274296D3F9B@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274296D3F9B@dlee13.ent.ti.com>
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
>> Hi Richard,
>>
>> Which board you used to test theses patches?
> 
> I didn't fully test MMC.  I did make sure it fixed the boot lock up.
> 
> My board is a 'HRP' version using the latest ES rev of the 2420.
> 
>> As we've (me and Briglia) mentioned, the mmc it's not working on my H4
>> board. I'm still investigating to find out the problem.
> 
> What does not working mean?  No boot, crash on card insertion, card not
> taking some command?

Card is not being recognized. The clocks are initialized, after that, nothing happens when a mmc card is
inserted/removed. I guess it is ok for H4 once the driver does not support two MMC slots, yet.

> 
> Did you try with the simple 1 line patch I submitted also?

We tested using the latest patches sent by Tony.

Anderson Briglia
